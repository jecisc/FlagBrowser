"
I am a test class to test StFBFlag behavior. I reset the global state (case sensitivity and Pharo flags display) between tests.
"
Class {
	#name : 'StFBFlagTest',
	#superclass : 'TestCase',
	#instVars : [
		'savedCaseSensitive',
		'savedShowPharoFlags'
	],
	#category : 'FlagBrowser-Tests-Model',
	#package : 'FlagBrowser-Tests',
	#tag : 'Model'
}

{ #category : 'helpers' }
StFBFlagTest >> flagNodesFor: aSelector [

	^ (StFBFlagTestFixture >> aSelector) flagNodes
]

{ #category : 'running' }
StFBFlagTest >> setUp [

	super setUp.
	savedCaseSensitive := StFBFlag caseSensitive.
	savedShowPharoFlags := StFBFlag showPharoFlags.
	StFBFlag caseSensitive: true.
	StFBFlag showPharoFlags: true
]

{ #category : 'running' }
StFBFlagTest >> tearDown [

	StFBFlag caseSensitive: savedCaseSensitive.
	StFBFlag showPharoFlags: savedShowPharoFlags.
	super tearDown
]

{ #category : 'tests' }
StFBFlagTest >> testAddLocations [

	| flag location |
	flag := StFBObjectFlag parameter: 42 locations: OrderedCollection new.
	location := StFBLocation class: Point selector: #x interval: (1 to: 1).
	flag addLocations: { location }.
	self assert: flag locations size equals: 1.
	self assert: flag locations first equals: location
]

{ #category : 'tests' }
StFBFlagTest >> testAddNewCreatesFlag [

	| flags |
	flags := OrderedCollection new.
	StFBFlag
		addNew: StFBSymbolFlag
		for: #jeciscTestSymbolFlag
		with: (self flagNodesFor: #methodWithSymbolFlag)
		in: flags.
	self assert: flags size equals: 1.
	self assert: flags first class equals: StFBSymbolFlag.
	self assert: flags first parameter equals: #jeciscTestSymbolFlag.
	self assert: flags first locations size equals: 1
]

{ #category : 'tests' }
StFBFlagTest >> testAddNewDoesNotMergeCaseSensitiveSymbols [

	| flags |
	flags := OrderedCollection new.
	StFBFlag
		addNew: StFBSymbolFlag
		for: #TestSymbolFlag
		with: (self flagNodesFor: #methodWithSymbolFlag)
		in: flags.
	StFBFlag
		addNew: StFBSymbolFlag
		for: #testSymbolFlag
		with: (self flagNodesFor: #methodWithLowCaseSymbolFlag)
		in: flags.
	self assert: flags size equals: 2
]

{ #category : 'tests' }
StFBFlagTest >> testAddNewFiltersPharoLocations [

	| flags |
	StFBFlag showPharoFlags: false.
	flags := OrderedCollection new.
	StFBFlag
		addNew: StFBObjectFlag
		for: 42
		with: (AthensBalloonStrokePaint >> #capButt) flagNodes
		in: flags.
	self assert: flags isEmpty
]

{ #category : 'tests' }
StFBFlagTest >> testAddNewKeepsNonPharoLocations [

	| flags |
	StFBFlag showPharoFlags: false.
	flags := OrderedCollection new.
	StFBFlag
		addNew: StFBSymbolFlag
		for: #jeciscTestSymbolFlag
		with: (self flagNodesFor: #methodWithSymbolFlag)
		in: flags.
	self assert: flags size equals: 1.
	self assert: flags first locations size equals: 1
]

{ #category : 'tests' }
StFBFlagTest >> testAddNewKeepsPharoLocationWithShowPharoFlags [

	| flags |
	StFBFlag showPharoFlags: true.
	flags := OrderedCollection new.
	StFBFlag
		addNew: StFBObjectFlag
		for: 42
		with: (AthensBalloonStrokePaint >> #capButt) flagNodes
		in: flags.
	self assert: flags size equals: 1.
	self assert: flags first locations size equals: 1
]

{ #category : 'tests' }
StFBFlagTest >> testAddNewMergesCaseInsensitiveStrings [

	| flags |
	StFBFlag caseSensitive: false.
	flags := OrderedCollection new.
	StFBFlag
		addNew: StFBStringFlag
		for: 'Flag Test'
		with: (self flagNodesFor: #methodWithStringFlag)
		in: flags.
	StFBFlag
		addNew: StFBStringFlag
		for: 'flag test'
		with: (self flagNodesFor: #methodWithLowCaseStringFlag)
		in: flags.
	self assert: flags size equals: 1.
	self assert: flags first parameter equals: 'Flag test'.
	self assert: flags first locations size equals: 2
]

{ #category : 'tests' }
StFBFlagTest >> testAddNewMergesCaseInsensitiveSymbols [

	| flags |
	StFBFlag caseSensitive: false.
	flags := OrderedCollection new.
	StFBFlag
		addNew: StFBSymbolFlag
		for: #jeciscTestSymbolFlag
		with: (self flagNodesFor: #methodWithSymbolFlag)
		in: flags.
	StFBFlag
		addNew: StFBSymbolFlag
		for: #jecisctestSymbolFlag
		with: (self flagNodesFor: #methodWithLowCaseSymbolFlag)
		in: flags.
	self assert: flags size equals: 1.
	self assert: flags first parameter equals: #Jecisctestsymbolflag.
	self assert: flags first locations size equals: 2
]

{ #category : 'tests' }
StFBFlagTest >> testAllInSystemForSymbol [

	self assert: (StFBSymbolFlag allInSystem anySatisfy: [ :flag | flag parameter = #jeciscTestSymbolFlag ])
]

{ #category : 'tests' }
StFBFlagTest >> testFlagKind [

	self assert: (StFBFlag flagClassFor: 42) equals: StFBObjectFlag.
	self assert: (StFBFlag flagClassFor: (1 to: 3)) equals: StFBObjectFlag.
	self assert: (StFBFlag flagClassFor: Object new) equals: StFBObjectFlag.
	self assert: (StFBFlag flagClassFor: 'foo') equals: StFBStringFlag.
	self assert: (StFBFlag flagClassFor: #foo) equals: StFBSymbolFlag
]

{ #category : 'tests' }
StFBFlagTest >> testToLocationsCreatesLocations [

	| nodes node locations |
	nodes := self flagNodesFor: #methodWithSymbolFlag.
	node := nodes first.
	locations := StFBFlag toLocations: nodes.
	self assert: locations size equals: 1.
	self assert: locations first classLocation equals: StFBFlagTestFixture.
	self assert: locations first selector equals: #methodWithSymbolFlag.
	self assert: locations first interval equals: node sourceInterval
]
