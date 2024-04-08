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
		'CaseSensitive'
	],
	#category : 'FlagBrowser-Model',
	#package : 'FlagBrowser',
	#tag : 'Model'
}

{ #category : 'accessing' }
StFBFlag class >> addNew: aClass for: argument with: rbNodes in: flags [
	self caseSensitive
		ifFalse: [ | insensitiveArgument |
			insensitiveArgument := argument asString asLowercase.
			flags
				detect: [ :flag | flag parameter asString asLowercase = insensitiveArgument and: [ flag parameter class = argument class ] ]
				ifFound: [ :flag | 
					^ flag
						addLocations: (self toLocations: rbNodes);
						insensitiveParameter ] ].

	flags add: (aClass parameter: argument locations: (self toLocations: rbNodes))
]

{ #category : 'accessing' }
StFBFlag class >> allFlags [
	^ self isAbstract ifTrue: [ self allFlagsInSystem ] ifFalse: [ self allInSystem ]
]

{ #category : 'accessing' }
StFBFlag class >> allFlagsInSystem [
	| flagNodes flags |
	flags := OrderedCollection new.
	flagNodes := #flag: senders
		flatCollect: [ :sender | sender compiledMethod ast allChildren select: [ :child | child isMessage and: [ child selector = #flag: ] ] ].
	(flagNodes groupedBy: [ :node | node arguments first value ])
		keysAndValuesDo: [ :argument :rbNodes | 
			self
				addNew: (self flagClassFor: argument)
				for: argument
				with: rbNodes
				in: flags ].
	^ flags
]

{ #category : 'accessing' }
StFBFlag class >> allInSystem [
	| flagNodes flags |
	self isAbstract ifTrue: [ ^ self error: 'This method can be called only on concrete classes.' ].

	flags := OrderedCollection new.
	flagNodes := #flag: senders
		flatCollect: [ :sender | sender compiledMethod ast allChildren select: [ :child | child isMessage and: [ child selector = #flag: ] ] ].
	(flagNodes groupedBy: [ :node | node arguments first value ])
		keysAndValuesDo: [ :argument :rbNodes | 
			(StFBFlag flagClassFor: argument) = self
				ifTrue: [ self
						addNew: self
						for: argument
						with: rbNodes
						in: flags ] ].
	^ flags
]

{ #category : 'accessing' }
StFBFlag class >> caseSensitive [
	^ CaseSensitive ifNil: [ CaseSensitive := true ]
]

{ #category : 'accessing' }
StFBFlag class >> caseSensitive: anObject [
	CaseSensitive := anObject
]

{ #category : 'accessing' }
StFBFlag class >> flagClassFor: aFlagArgument [
	^ (self allSubclasses sorted: #priority descending) detect: [ :subclass | subclass matchesArgument: aFlagArgument ]
]

{ #category : 'testing' }
StFBFlag class >> isAbstract [
	^ self = StFBFlag
]

{ #category : 'testing' }
StFBFlag class >> matchesArgument: aFlagArgument [
	^ self subclassResponsibility
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

{ #category : '*FlagBrowser-UI' }
StFBFlag class >> title [
	^ 'All flags'
]

{ #category : 'accessing' }
StFBFlag class >> toLocations: aCollectionOfRBNodes [
	^ aCollectionOfRBNodes
		collect: [ :node | 
			| methodNode |
			methodNode := node methodNode.
			StFBLocation class: methodNode methodClass selector: methodNode selector interval: node sourceInterval ]
]

{ #category : 'adding' }
StFBFlag >> addLocations: aCollection [
	self locations addAll: aCollection
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
