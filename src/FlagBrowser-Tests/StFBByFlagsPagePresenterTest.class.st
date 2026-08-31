"
I test the interactions of StFBByFlagsPagePresenter: switching the mode droplist refills the flags list, toggling case sensitivity relists and merges flags, selecting a flag transmits its locations to the table and shows the source in the code presenter, and refresh preserves the selection.
"
Class {
	#name : 'StFBByFlagsPagePresenterTest',
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

{ #category : 'running' }
StFBByFlagsPagePresenterTest >> setUp [

	super setUp.
	savedCaseSensitive := StFBFlag caseSensitive.
	savedShowPharoFlags := StFBFlag showPharoFlags.
	StFBFlag caseSensitive: true.
	StFBFlag showPharoFlags: false.
	presenter := StFBByFlagsPagePresenter new
]

{ #category : 'running' }
StFBByFlagsPagePresenterTest >> tearDown [

	presenter window ifNotNil: [ :window | window close ].
	StFBFlag caseSensitive: savedCaseSensitive.
	StFBFlag showPharoFlags: savedShowPharoFlags.
	super tearDown
]

{ #category : 'tests' }
StFBByFlagsPagePresenterTest >> testRefreshPreservesSelectedFlag [

	| flag |
	flag := presenter flagsList items detect: [ :f | f parameter = #jeciscTestSymbolFlag ].
	presenter flagsList listPresenter clickAtIndex: (presenter flagsList items indexOf: flag).

	presenter refresh.

	self assert: presenter flagsList selectedItem parameter equals: #jeciscTestSymbolFlag.
	self assert: presenter locationsTable selectedItem selector equals: #methodWithSymbolFlag
]

{ #category : 'tests' }
StFBByFlagsPagePresenterTest >> testSelectingFlagTransmitsLocations [

	| flag |
	flag := presenter flagsList items detect: [ :f | f parameter = #jeciscTestSymbolFlag ].
	presenter flagsList listPresenter clickAtIndex: (presenter flagsList items indexOf: flag).

	self assert: presenter locationsTable items size equals: 1.
	self assert: presenter locationsTable selectedItem selector equals: #methodWithSymbolFlag.
	self assert: presenter locationsTable selectedItem classLocation equals: StFBFlagTestFixture
]

{ #category : 'tests' }
StFBByFlagsPagePresenterTest >> testSelectingLocationShowsSourceInCode [

	| flag |
	flag := presenter flagsList items detect: [ :f | f parameter = #jeciscTestSymbolFlag ].
	presenter flagsList listPresenter clickAtIndex: (presenter flagsList items indexOf: flag).
	presenter locationsTable clickItem: 1.

	self assert: presenter code text equals: (StFBFlagTestFixture >> #methodWithSymbolFlag) sourceCode.
	self assert: presenter code behavior equals: StFBFlagTestFixture
]

{ #category : 'tests' }
StFBByFlagsPagePresenterTest >> testSelectingObjectModeShowsObjectFlags [

	presenter modeDropbox selectItem: StFBObjectFlag.

	self assert: (presenter flagsList items anySatisfy: [ :flag | flag parameter = 42 ])
]

{ #category : 'tests' }
StFBByFlagsPagePresenterTest >> testSelectingStringModeShowsStringFlags [

	presenter modeDropbox selectItem: StFBStringFlag.

	self assert: (presenter flagsList items allSatisfy: [ :flag | flag isKindOf: StFBStringFlag ]).
	self assert: ((presenter flagsList items collect: #parameter) includesAll: { 'Flag Test'. 'flag test' })
]

{ #category : 'tests' }
StFBByFlagsPagePresenterTest >> testTogglingCaseSensitivityUpdatesGlobalAndMergesFlags [

	presenter caseCheckbox state: false.
	
	self deny: StFBFlag caseSensitive.
	self assert: (presenter flagsList items noneSatisfy: [ :flag | flag parameter = #jeciscTestSymbolFlag ]).
	self assert: (presenter flagsList items anySatisfy: [ :flag | flag parameter = #Jecisctestsymbolflag ])
]
