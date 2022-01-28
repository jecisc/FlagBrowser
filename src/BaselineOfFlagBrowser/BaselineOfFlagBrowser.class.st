Class {
	#name : #BaselineOfFlagBrowser,
	#superclass : #BaselineOf,
	#category : #BaselineOfFlagBrowser
}

{ #category : #baselines }
BaselineOfFlagBrowser >> baseline: spec [

	<baseline>
	spec for: #common do: [ spec package: 'FlagBrowser-Model' ].

	spec for: #'pharo8.x' do: [ spec package: 'FlagBrowser-Spec-Pharo8' with: [ spec requires: #( 'FlagBrowser-Model' ) ] ].

	spec for: (self pharoVersionsFrom: 9) do: [ spec package: 'FlagBrowser-Spec-Pharo9' with: [ spec requires: #( 'FlagBrowser-Model' ) ] ]
]

{ #category : #baselines }
BaselineOfFlagBrowser >> pharoVersionsFrom: aVersion [
	^ (aVersion to: SystemVersion current major) collect: [ :v | ('pharo' , v asString , '.x') asSymbol ]
]
