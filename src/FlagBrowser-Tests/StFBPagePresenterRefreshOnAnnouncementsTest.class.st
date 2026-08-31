"
I test how StFBPagePresenter reacts to method announcements: a page must refresh only when the announced method addition, removal or update concerns a flag.
"
Class {
	#name : 'StFBPagePresenterRefreshOnAnnouncementsTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'FlagBrowser-Tests-UI',
	#package : 'FlagBrowser-Tests',
	#tag : 'UI'
}

{ #category : 'helpers' }
StFBPagePresenterRefreshOnAnnouncementsTest >> methodWithoutFlag [

	^ self
]

{ #category : 'running' }
StFBPagePresenterRefreshOnAnnouncementsTest >> setUp [

	super setUp.
	presenter := StFBTestPagePresenter new
]

{ #category : 'tests' }
StFBPagePresenterRefreshOnAnnouncementsTest >> testRefreshOnAdditionDoesNotRefreshMethodWithoutFlag [

	presenter refreshOnAddition: (MethodAdded method: StFBFlagTestFixture >> #methodWithoutFlag).
	self assert: presenter refreshCount equals: 0
]

{ #category : 'tests' }
StFBPagePresenterRefreshOnAnnouncementsTest >> testRefreshOnAdditionRefreshesMethodWithFlag [

	presenter refreshOnAddition: (MethodAdded method: StFBFlagTestFixture >> #methodWithSymbolFlag).
	self assert: presenter refreshCount equals: 1
]

{ #category : 'tests' }
StFBPagePresenterRefreshOnAnnouncementsTest >> testRefreshOnRemovalDoesNotRefreshMethodWithoutFlag [

	presenter refreshOnRemoval: (MethodRemoved new method: StFBFlagTestFixture >> #methodWithoutFlag).
	self assert: presenter refreshCount equals: 0
]

{ #category : 'tests' }
StFBPagePresenterRefreshOnAnnouncementsTest >> testRefreshOnRemovalRefreshesMethodWithFlag [

	presenter refreshOnRemoval: (MethodRemoved new method: StFBFlagTestFixture >> #methodWithTwoFlags).
	self assert: presenter refreshCount equals: 1
]

{ #category : 'tests' }
StFBPagePresenterRefreshOnAnnouncementsTest >> testRefreshOnUpdateDoesNotRefreshWhenFlagsUnchanged [

	presenter refreshOnUpdate:
		(MethodModified methodChangedFrom: StFBFlagTestFixture >> #methodWithSymbolFlag to: StFBFlagTestFixture >> #methodWithSymbolFlag oldProtocol: nil).
	self assert: presenter refreshCount equals: 0
]

{ #category : 'tests' }
StFBPagePresenterRefreshOnAnnouncementsTest >> testRefreshOnUpdateRefreshesWhenFlagAdded [

	presenter refreshOnUpdate:
		(MethodModified methodChangedFrom: StFBFlagTestFixture >> #methodWithoutFlag to: StFBFlagTestFixture >> #methodWithSymbolFlag oldProtocol: nil).
	self assert: presenter refreshCount equals: 1
]

{ #category : 'tests' }
StFBPagePresenterRefreshOnAnnouncementsTest >> testRefreshOnUpdateRefreshesWhenFlagRemoved [

	presenter refreshOnUpdate:
		(MethodModified methodChangedFrom: StFBFlagTestFixture >> #methodWithSymbolFlag to: StFBFlagTestFixture >> #methodWithoutFlag oldProtocol: nil).
	self assert: presenter refreshCount equals: 1
]
