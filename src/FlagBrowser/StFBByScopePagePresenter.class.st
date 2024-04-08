"
Description
--------------------

I am a presenter showing the flags in a scope.
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	scopesList:		<aListPresenter>	The list of scopes the user can select.

"
Class {
	#name : 'StFBByScopePagePresenter',
	#superclass : 'StFBPagePresenter',
	#instVars : [
		'scopesList'
	],
	#category : 'FlagBrowser-UI',
	#package : 'FlagBrowser',
	#tag : 'UI'
}

{ #category : 'specs' }
StFBByScopePagePresenter class >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 250;
		  add: #scopesList;
		  add: (SpPanedLayout newVertical
				   add: #locationsTable;
				   add: #code;
				   yourself);
		  yourself
]

{ #category : 'specs' }
StFBByScopePagePresenter class >> defaultSpec [
	self flag: #pharo11.
	^ SpPanedLayout newHorizontal
		  positionOfSlider: 250;
		  add: #scopesList;
		  add: (SpPanedLayout newVertical
				   add: #locationsTable;
				   add: #code;
				   yourself);
		  yourself
]

{ #category : 'testing' }
StFBByScopePagePresenter class >> isAbstract [
	^ self = StFBByScopePagePresenter
]

{ #category : 'initialization' }
StFBByScopePagePresenter >> connectPresenters [
	| locationsByScope |
	super connectPresenters.
	locationsByScope := (StFBFlag allFlags flatCollect: #locations) groupedBy: self scopeSelector.

	scopesList transmitTo: locationsTable transform: [ :scope | scope ifNotNil: [ locationsByScope at: scope ] ifNil: [ #() ] ] postTransmission: [ :destination | destination selectIndex: 1 ].

	scopesList
		items: locationsByScope keys;
		selectIndex: 1
]

{ #category : 'initialization' }
StFBByScopePagePresenter >> initializeWidgets [
	super initializeWidgets.
	scopesList := self newList.
	scopesList
		display: #name;
		sortingBlock: #name ascending
]

{ #category : 'initialization' }
StFBByScopePagePresenter >> scopeSelector [
	^ self subclassResponsibility
]
