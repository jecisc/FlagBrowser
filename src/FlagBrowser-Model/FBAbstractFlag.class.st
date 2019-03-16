Class {
	#name : #FBAbstractFlag,
	#superclass : #Object,
	#instVars : [
		'parameter',
		'nodes'
	],
	#category : #'FlagBrowser-Model'
}

{ #category : #accessing }
FBAbstractFlag class >> flagClassFor: aFlagArgument [
	^ (self allSubclasses sorted: #priority descending) detect: [ :subclass | subclass matchesArgument: aFlagArgument ]
]

{ #category : #testing }
FBAbstractFlag class >> matchesArgument: aFlagArgument [
	^ self subclassResponsibility
]

{ #category : #accessing }
FBAbstractFlag class >> priority [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
FBAbstractFlag >> TODELETE [
	| flagNodes flags |
	flagNodes := #flag: senders flatCollect: [ :sender | sender compiledMethod ast allChildren select: [ :child | child isMessage and: [ child selector = #flag: ] ] ].

	flags := OrderedCollection new.

	(flagNodes groupedBy: [ :node | node arguments first value ])
		keysAndValuesDo: [ :argument :flagNode | 
			flags
				add:
					((FBAbstractFlag flagClassFor: argument) new
						parameter: argument;
						nodes: flagNode;
						yourself) ].

	flags
]

{ #category : #accessing }
FBAbstractFlag >> nodes [
	^ nodes
]

{ #category : #accessing }
FBAbstractFlag >> nodes: anObject [
	nodes := anObject
]

{ #category : #accessing }
FBAbstractFlag >> parameter [
	^ parameter
]

{ #category : #accessing }
FBAbstractFlag >> parameter: anObject [
	parameter := anObject
]
