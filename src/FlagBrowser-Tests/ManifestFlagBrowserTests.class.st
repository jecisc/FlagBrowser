"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestFlagBrowserTests',
	#superclass : 'PackageManifest',
	#category : 'FlagBrowser-Tests-Manifest',
	#package : 'FlagBrowser-Tests',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestFlagBrowserTests class >> ruleCodeCruftLeftInMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#'FlagBrowser-Tests')) #'2026-08-31T01:45:13.795139+02:00') )
]
