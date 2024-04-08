"
Description
--------------------

I am a presenter showing the flags in packages.
"
Class {
	#name : 'StFBByPackagesPagePresenter',
	#superclass : 'StFBByScopePagePresenter',
	#category : 'FlagBrowser-UI',
	#package : 'FlagBrowser',
	#tag : 'UI'
}

{ #category : 'specs' }
StFBByPackagesPagePresenter class >> icon [
	^ #package
]

{ #category : 'accessing' }
StFBByPackagesPagePresenter class >> priority [
	^ 5
]

{ #category : 'specs' }
StFBByPackagesPagePresenter class >> title [
	^ 'By package'
]

{ #category : 'initialization' }
StFBByPackagesPagePresenter >> initializeWidgets [
	super initializeWidgets.

	locationsTable
		addColumn: (SpStringTableColumn title: 'Class' evaluated: #classLocation);
		addColumn: (SpStringTableColumn title: 'Method' evaluated: #selector);
		addColumn: (SpStringTableColumn title: 'Flag parameter' evaluated: [ :location | location flag parameter ])
]

{ #category : 'initialization' }
StFBByPackagesPagePresenter >> scopeSelector [
	^ #package
]
