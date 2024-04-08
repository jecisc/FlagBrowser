Class {
	#name : 'BaselineOfFlagBrowser',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfFlagBrowser',
	#package : 'BaselineOfFlagBrowser'
}

{ #category : 'baselines' }
BaselineOfFlagBrowser >> baseline: spec [

	<baseline>
	spec for: #common do: [ spec package: 'FlagBrowser' ]
]
