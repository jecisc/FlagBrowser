"
Description
--------------------

I represent a Flag. A flag is a call to the method Object>>flag with a specific parameter. 

I save the parameter of the flag (it can be a symbol, a string or an object) and its location (the method it is in).

I am an abstract classes and my subclasses will be diferenciated by their parameter kind.
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	locations:		<aCollection>	A collection of FBLocation
	parameter:		<anObject>		Parameter of the flag. Can be a Symbol, a String or an object.

"
Class {
	#name : 'StFBFlag',
	#superclass : 'Object',
	#instVars : [
		'parameter',
		'locations'
	],
	#classVars : [
		'CaseSensitive',
		'FlagsCache',
		'ShowPharoFlags'
	],
	#category : 'FlagBrowser-Model',
	#package : 'FlagBrowser',
	#tag : 'Model'
}

{ #category : 'accessing' }
StFBFlag class >> addNew: aClass for: argument with: astNodes in: flags [

	| newLocations |
	newLocations := self toLocations: astNodes.

	self showPharoFlags ifFalse: [
			| pharoPackages |
			pharoPackages := SystemBuildInfo current systemPackageNames.
			newLocations := newLocations reject: [ :location | pharoPackages includes: location package name ].
			newLocations ifEmpty: [ ^ self ] ].

	self caseSensitive ifFalse: [
			| insensitiveArgument |
			insensitiveArgument := argument asString asLowercase.
			flags
				detect: [ :flag | flag parameter asString asLowercase = insensitiveArgument and: [ flag parameter class = argument class ] ]
				ifFound: [ :flag |
						^ flag
							  addLocations: newLocations;
							  insensitiveParameter ] ].

	flags add: (aClass parameter: argument locations: newLocations)
]

{ #category : 'accessing' }
StFBFlag class >> allFlags [

	^ self isAbstract
		  ifTrue: [ self allFlagsInSystem ]
		  ifFalse: [ self allInSystem ]
]

{ #category : 'accessing' }
StFBFlag class >> allFlagsInSystem [

	^ FlagsCache ifNil: [ FlagsCache := self newFlagsInSystem ]
]

{ #category : 'accessing' }
StFBFlag class >> allInSystem [

	self isAbstract ifTrue: [ ^ self error: 'This method can be called only on concrete classes.' ].

	^ (StFBFlag allFlags select: [ :flag | flag class = self ]) asOrderedCollection
]

{ #category : 'accessing' }
StFBFlag class >> caseSensitive [
	^ CaseSensitive ifNil: [ CaseSensitive := true ]
]

{ #category : 'accessing' }
StFBFlag class >> caseSensitive: anObject [

	CaseSensitive := anObject.
	self invalidateFlagsCache
]

{ #category : 'accessing' }
StFBFlag class >> flagClassFor: aFlagArgument [
	^ (self allSubclasses sorted: #priority descending) detect: [ :subclass | subclass matchesArgument: aFlagArgument ]
]

{ #category : 'class initialization' }
StFBFlag class >> initialize [

	SystemAnnouncer uniqueInstance weak
		when: MethodAdded send: #invalidateFlagsCache to: self;
		when: MethodRemoved send: #invalidateFlagsCache to: self;
		when: MethodModified send: #invalidateFlagsCache to: self;
		when: ClassAdded send: #invalidateFlagsCache to: self;
		when: ClassRemoved send: #invalidateFlagsCache to: self;
		when: ClassRepackaged send: #invalidateFlagsCache to: self;
		when: MethodRepackaged send: #invalidateFlagsCache to: self
]

{ #category : 'private' }
StFBFlag class >> invalidateFlagsCache [

	FlagsCache := nil
]

{ #category : 'testing' }
StFBFlag class >> isAbstract [
	^ self = StFBFlag
]

{ #category : 'testing' }
StFBFlag class >> matchesArgument: aFlagArgument [
	^ self subclassResponsibility
]

{ #category : 'private' }
StFBFlag class >> newFlagsInSystem [

	| flagNodes flags |
	flags := OrderedCollection new.
	flagNodes := #flag: senders flatCollect: [ :sender | sender compiledMethod flagNodes ].
	(flagNodes groupedBy: [ :node | node arguments first value ]) keysAndValuesDo: [ :argument :rbNodes |
			self
				addNew: (self flagClassFor: argument)
				for: argument
				with: rbNodes
				in: flags ].
	^ flags
]

{ #category : 'instance creation' }
StFBFlag class >> parameter: anArgument locations: aCollectionOfNodes [
	^ self new
		parameter: anArgument;
		locations: aCollectionOfNodes;
		yourself
]

{ #category : 'accessing' }
StFBFlag class >> priority [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
StFBFlag class >> showPharoFlags [

	^ ShowPharoFlags ifNil: [ ShowPharoFlags := false ]
]

{ #category : 'accessing' }
StFBFlag class >> showPharoFlags: aBoolean [

	ShowPharoFlags := aBoolean.
	self invalidateFlagsCache
]

{ #category : 'accessing' }
StFBFlag class >> title [
	^ 'All flags'
]

{ #category : 'accessing' }
StFBFlag class >> toLocations: aCollectionOfASTNodes [
	^ aCollectionOfASTNodes
		collect: [ :node | 
			| methodNode |
			methodNode := node methodNode.
			StFBLocation class: methodNode methodClass selector: methodNode selector interval: node sourceInterval ]
]

{ #category : 'adding' }
StFBFlag >> addLocations: aCollection [

	self locations addAll: aCollection.
	aCollection do: [ :location | location flag: self ]
]

{ #category : 'accessing' }
StFBFlag >> insensitiveParameter [
	self subclassResponsibility
]

{ #category : 'accessing' }
StFBFlag >> locations [
	^ locations
]

{ #category : 'accessing' }
StFBFlag >> locations: anObject [
	locations := anObject.
	locations do: [ :location | location flag: self ]
]

{ #category : 'accessing' }
StFBFlag >> parameter [
	^ parameter
]

{ #category : 'accessing' }
StFBFlag >> parameter: anObject [
	parameter := anObject
]

{ #category : 'printing' }
StFBFlag >> printOn: aStream [
	super printOn: aStream.

	aStream
		<< $[;
		print: parameter;
		<< $];
		<< $(;
		print: locations size;
		<< $)
]
