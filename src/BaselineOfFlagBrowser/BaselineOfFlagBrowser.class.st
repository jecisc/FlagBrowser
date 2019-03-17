Class {
	#name : #BaselineOfFlagBrowser,
	#superclass : #BaselineOf,
	#category : #BaselineOfFlagBrowser
}

{ #category : #baselines }
BaselineOfFlagBrowser >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'FlagBrowser-Model';
				package: 'FlagBrowser-Presentation' with: [ spec requires: #('FlagBrowser-Model') ];
				package: 'FlagBrowser-Spec' with: [ spec requires: #('FlagBrowser-Presentation') ] ]
]
