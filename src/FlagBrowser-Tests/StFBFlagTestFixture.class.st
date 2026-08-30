"
I am a test fixture class that defines methods containing flag calls, so that I can test the FlagBrowser model against the running image.
"
Class {
	#name : 'StFBFlagTestFixture',
	#superclass : 'Object',
	#category : 'FlagBrowser-Tests-Model',
	#package : 'FlagBrowser-Tests',
	#tag : 'Model'
}

{ #category : 'flags' }
StFBFlagTestFixture >> methodWithLowCaseStringFlag [

	self flag: 'flag test'
]

{ #category : 'flags' }
StFBFlagTestFixture >> methodWithLowCaseSymbolFlag [

	self flag: #jecisctestSymbolFlag
]

{ #category : 'flags' }
StFBFlagTestFixture >> methodWithObjectFlag [

	self flag: 42
]

{ #category : 'flags' }
StFBFlagTestFixture >> methodWithStringFlag [

	self flag: 'Flag Test'
]

{ #category : 'flags' }
StFBFlagTestFixture >> methodWithSymbolFlag [

	self flag: #jeciscTestSymbolFlag
]

{ #category : 'flags' }
StFBFlagTestFixture >> methodWithTwoFlags [

	self flag: #jeciscTestFirstFlag.
	self flag: #jeciscTestSecondFlag
]
