"
Description
--------------------

I am a presenter showing the flags in classes.
"
Class {
	#name : 'StFBByClassesPagePresenter',
	#superclass : 'StFBByScopePagePresenter',
	#category : 'FlagBrowser-UI',
	#package : 'FlagBrowser',
	#tag : 'UI'
}

{ #category : 'specs' }
StFBByClassesPagePresenter class >> icon [
	^ #class
]

{ #category : 'accessing' }
StFBByClassesPagePresenter class >> priority [
	^ 10
]

{ #category : 'specs' }
StFBByClassesPagePresenter class >> title [
	^ 'By class'
]

{ #category : 'initialization' }
StFBByClassesPagePresenter >> initializeWidgets [
	super initializeWidgets.

	locationsTable
		addColumn: (SpStringTableColumn title: 'Method' evaluated: #selector);
		addColumn: (SpStringTableColumn title: 'Flag parameter' evaluated: [ :location | location flag parameter ])
]

{ #category : 'initialization' }
StFBByClassesPagePresenter >> scopeSelector [
	^ #classLocation
]
