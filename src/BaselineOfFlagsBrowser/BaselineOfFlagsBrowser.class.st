Class {
	#name : #BaselineOfFlagsBrowser,
	#superclass : #BaselineOf,
	#category : #BaselineOfFlagsBrowser
}

{ #category : #baselines }
BaselineOfFlagsBrowser >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'FlagBrowser-Model';
				package: 'FlagBrowser-Presentation' with: [ spec requires: #('FlagBrowser-Model') ];
				package: 'FlagBrowser-Spec' with: [ spec requires: #('FlagBrowser-Presentation') ] ]
]
