Class {
	#name : #FBByFlagsPagePresenter,
	#superclass : #FBPagePresenter,
	#instVars : [
		'selectedMode',
		'modeDropbox',
		'flagsList',
		'locationsTable'
	],
	#category : #'FlagBrowser-Spec'
}

{ #category : #specs }
FBByFlagsPagePresenter class >> defaultSpec [
	self flag: #todo. "check problems"
	^ SpecBoxLayout newVertical
		add: #modeDropbox withConstraints: [ :constraints | constraints height: 30 ];
		add:
			(SpecBoxLayout newHorizontal
				add: #flagsList" withConstraints: [ :constraints | constraints width: 100 ]";
				add: #locationsTable;
				yourself);
		yourself
]

{ #category : #specs }
FBByFlagsPagePresenter class >> icon [
	^ #breakpoint
]

{ #category : #accessing }
FBByFlagsPagePresenter class >> priority [
	^ 1
]

{ #category : #specs }
FBByFlagsPagePresenter class >> title [
	^ 'By flag'
]

{ #category : #accessing }
FBByFlagsPagePresenter >> flagsList [
	^ flagsList
]

{ #category : #accessing }
FBByFlagsPagePresenter >> flagsList: anObject [
	flagsList := anObject
]

{ #category : #initialization }
FBByFlagsPagePresenter >> initializePresenter [
	flagsList whenSelectionChangedDo: [ :selection | self locationsTable items: selection selectedItem locations ].
	
	modeDropbox
		whenSelectedItemChanged: [ :mode | self selectedMode: mode ];
		setSelectedItem: FBSymbolFlag
]

{ #category : #initialization }
FBByFlagsPagePresenter >> initializeWidgets [
	modeDropbox := self newDropList.
	flagsList := self newList.
	locationsTable := self newTable.

	modeDropbox
		items: FBFlag withAllSubclasses;
		displayBlock: [ :class | class title ].

	flagsList displayBlock: [ :flag | flag parameter asString , ' (' , flag locations size asString , ' occurences)' ].

	locationsTable addColumn: (StringTableColumn title: 'Class' evaluated: [ :location | location asString ])	;
		addColumn: (StringTableColumn title: 'Method' evaluated: [ :location | ])
]

{ #category : #accessing }
FBByFlagsPagePresenter >> locationsTable [
	^ locationsTable
]

{ #category : #accessing }
FBByFlagsPagePresenter >> locationsTable: anObject [
	locationsTable := anObject
]

{ #category : #accessing }
FBByFlagsPagePresenter >> modeDropbox [
	^ modeDropbox
]

{ #category : #accessing }
FBByFlagsPagePresenter >> modeDropbox: anObject [
	modeDropbox := anObject
]

{ #category : #accessing }
FBByFlagsPagePresenter >> selectedMode [
	^ selectedMode
]

{ #category : #accessing }
FBByFlagsPagePresenter >> selectedMode: anObject [
	selectedMode := anObject.
	self flagsList
		ifNotNil: [ :list | 
			list
				items: selectedMode allFlags;
				selectIndex: 1 ]
]
