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
		'scopesList',
		'locationsByScope'
	],
	#category : 'FlagBrowser-UI',
	#package : 'FlagBrowser',
	#tag : 'UI'
}

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

	super connectPresenters.


	scopesList
		transmitTo: locationsTable
		transform: [ :scope |
				scope
					ifNotNil: [
							locationsByScope := (StFBFlag allFlags flatCollect: #locations) groupedBy: self scopeSelector.
							locationsByScope at: scope ]
					ifNil: [ #(  ) ] ]
		postTransmission: [ :destination | destination selectIndex: 1 ].

	self refresh
]

{ #category : 'layout' }
StFBByScopePagePresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 250;
				   add: #scopesList;
				   add: (SpPanedLayout newVertical
						    add: #locationsTable;
						    add: #code;
						    yourself);
				   yourself);
		  add: #showPharoFlagsCheckbox withConstraints: [ :constraints | constraints height: 20 ];
		  yourself
]

{ #category : 'initialization' }
StFBByScopePagePresenter >> initializePresenters [

	super initializePresenters.
	scopesList := self newFilteringList.
	scopesList
		display: [ :scope | scope name , ' (' , (locationsByScope at: scope) size asString , ' flags)' ];
		sortingBlock: #name ascending
]

{ #category : 'private' }
StFBByScopePagePresenter >> refresh [

	| selected |
	selected := scopesList selectedItem.
	locationsByScope := (StFBFlag allFlags flatCollect: #locations) groupedBy: self scopeSelector.
	scopesList items: locationsByScope keys.

	(selected isNotNil and: [ scopesList items includes: selected ]) ifTrue: [ ^ scopesList selectItem: selected ].
	scopesList listPresenter selectIndex: 1.
	locationsTable selectIndex: 1
]

{ #category : 'initialization' }
StFBByScopePagePresenter >> scopeSelector [
	^ self subclassResponsibility
]
