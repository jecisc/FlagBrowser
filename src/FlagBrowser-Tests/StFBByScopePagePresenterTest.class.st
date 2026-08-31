"
I test the shared behavior of the scope pages (By package, By class): the scopes list content and sorting, the transmission of a selected scope to the locations table and the preservation of the scope selection on refresh.
"
Class {
	#name : 'StFBByScopePagePresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter',
		'savedCaseSensitive',
		'savedShowPharoFlags'
	],
	#category : 'FlagBrowser-Tests-UI',
	#package : 'FlagBrowser-Tests',
	#tag : 'UI'
}

{ #category : 'testing' }
StFBByScopePagePresenterTest class >> isAbstract [

	^ self = StFBByScopePagePresenterTest
]

{ #category : 'accessing' }
StFBByScopePagePresenterTest >> knownScopeName [

	self subclassResponsibility
]

{ #category : 'private' }
StFBByScopePagePresenterTest >> newPresenter [

	self subclassResponsibility
]

{ #category : 'running' }
StFBByScopePagePresenterTest >> setUp [

	super setUp.
	savedCaseSensitive := StFBFlag caseSensitive.
	savedShowPharoFlags := StFBFlag showPharoFlags.
	StFBFlag caseSensitive: true.
	StFBFlag showPharoFlags: false.
	presenter := self newPresenter
]

{ #category : 'running' }
StFBByScopePagePresenterTest >> tearDown [

	presenter window ifNotNil: [ :window | window close ].
	StFBFlag caseSensitive: savedCaseSensitive.
	StFBFlag showPharoFlags: savedShowPharoFlags.
	super tearDown
]

{ #category : 'tests' }
StFBByScopePagePresenterTest >> testRefreshPreservesSelectedKnownScope [

	| scope |
	scope := presenter scopesList items detect: [ :s | s name = self knownScopeName ].
	presenter scopesList listPresenter clickAtIndex: (presenter scopesList items indexOf: scope).

	presenter refresh.

	self assert: presenter scopesList selectedItem name equals: self knownScopeName
]

{ #category : 'tests' }
StFBByScopePagePresenterTest >> testScopesListSortedByScopeName [

	| names sorted |
	names := (presenter scopesList items collect: #name) asArray.
	sorted := names sorted: [ :a :b | a <= b ].

	self assert: names equals: sorted
]

{ #category : 'tests' }
StFBByScopePagePresenterTest >> testSelectingKnownScopeTransmitsLocations [

	| scope |
	scope := presenter scopesList items detect: [ :s | s name = self knownScopeName ].
	presenter scopesList listPresenter clickAtIndex: (presenter scopesList items indexOf: scope).

	self denyEmpty: presenter locationsTable items.
	self assert: (presenter locationsTable items anySatisfy: [ :location | location selector = #methodWithSymbolFlag ])
]
