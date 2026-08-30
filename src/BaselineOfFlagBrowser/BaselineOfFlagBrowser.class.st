Class {
	#name : 'BaselineOfFlagBrowser',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfFlagBrowser',
	#package : 'BaselineOfFlagBrowser'
}

{ #category : 'baselines' }
BaselineOfFlagBrowser >> baseline: spec [

	<baseline>
	spec for: #common do: [
			spec
				package: 'FlagBrowser';
				package: 'FlagBrowser-Tests' with: [ spec requires: 'FlagBrowser' ].
			spec
				group: 'Core' with: #( 'FlagBrowser' );
				group: 'Tests' with: #( 'FlagBrowser-Tests' ) ]
]
