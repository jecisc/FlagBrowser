"
I am a stub presenter used by StFBPagePresenterTest to observe refresh calls. My refresh method only increments refreshCount instead of doing real work.
"
Class {
	#name : 'StFBTestPagePresenter',
	#superclass : 'StFBPagePresenter',
	#instVars : [
		'refreshCount'
	],
	#category : 'FlagBrowser-Tests-UI',
	#package : 'FlagBrowser-Tests',
	#tag : 'UI'
}

{ #category : 'testing' }
StFBTestPagePresenter class >> isAbstract [

	^ true
]

{ #category : 'initialization' }
StFBTestPagePresenter >> initialize [

	super initialize.
	refreshCount := 0
]

{ #category : 'private' }
StFBTestPagePresenter >> refresh [

	refreshCount := refreshCount + 1
]

{ #category : 'accessing' }
StFBTestPagePresenter >> refreshCount [

	^ refreshCount
]
