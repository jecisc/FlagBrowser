"
Description
--------------------

I am a page presenter to show the flags grouped by their parameters. 

The user will need to select a flag parameter and see all the locations with this parameter.

I will show different mode to browse the flags depending on the kin of their parameter. (Symbol, String, Object, Anyone)
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	flagsList:		<aListPresenter>		A list displaying the differents parameters possible.
	modeDropbox:		<aDropListPresenter>	A drop list to select the parameter kinds to show.

"
Class {
	#name : #FBByFlagsPagePresenter,
	#superclass : #FBPagePresenter,
	#instVars : [
		'modeDropbox',
		'flagsList',
		'caseCheckbox'
	],
	#category : #'FlagBrowser-Spec-Pharo9'
}

{ #category : #specs }
FBByFlagsPagePresenter class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: #modeDropbox withConstraints: [ :constraints | constraints height: 30 ];
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 250;
				   add: #flagsList;
				   add: (SpPanedLayout newVertical
						    add: #locationsTable;
						    add: #code;
						    yourself);
				   yourself);
		  add: #caseCheckbox withConstraints: [ :constraints | constraints height: 20 ];
		  yourself
]

{ #category : #specs }
FBByFlagsPagePresenter class >> defaultSpec [
	self flag: #pharo11.
	^ SpBoxLayout newVertical
		  add: #modeDropbox withConstraints: [ :constraints | constraints height: 30 ];
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 250;
				   add: #flagsList;
				   add: (SpPanedLayout newVertical
						    add: #locationsTable;
						    add: #code;
						    yourself);
				   yourself);
		  add: #caseCheckbox withConstraints: [ :constraints | constraints height: 20 ];
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
FBByFlagsPagePresenter >> caseCheckbox [
	^ caseCheckbox
]

{ #category : #accessing }
FBByFlagsPagePresenter >> caseCheckbox: anObject [
	caseCheckbox := anObject
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
	super initializePresenter.

	flagsList transmitTo: locationsTable transform: [ :item | item ifNotNil: #locations ifNil: [ #() ] ]  postTransmission: [ :destination | destination selectIndex: 1 ].
	modeDropbox transmitTo: flagsList transform: [ :item | item model allFlags ] postTransmission: [ :destination | destination selectIndex: 1 ].

	modeDropbox selectItem: FBSymbolFlag.
	caseCheckbox
		whenChangedDo: [ :value | 
			FBFlag caseSensitive: value.
			modeDropbox selectItem: modeDropbox selectedItem	"Used to refresh the list" ]
]

{ #category : #initialization }
FBByFlagsPagePresenter >> initializeWidgets [

	super initializeWidgets.
	modeDropbox := self newDropList.
	flagsList := self newList.
	caseCheckbox := self newCheckBox.
	modeDropbox
		items: FBFlag withAllSubclasses;
		display: [ :class | class title ].
	flagsList
		display: [ :flag | flag parameter asString , ' (' , flag locations size asString , ' occurences)' ];
		sortingBlock: [ :flag | flag parameter asString ] ascending.
	locationsTable
		addColumn: ((SpStringTableColumn title: 'Package' evaluated: #packageName)
				 beSortable;
				 yourself);
		addColumn: ((SpStringTableColumn title: 'Class' evaluated: #classLocation)
				 beSortable;
				 yourself);
		addColumn: ((SpStringTableColumn title: 'Method' evaluated: #selector)
				 beSortable;
				 yourself).
	caseCheckbox
		label: 'Case sensitive';
		state: FBFlag caseSensitive
]

{ #category : #accessing }
FBByFlagsPagePresenter >> modeDropbox [
	^ modeDropbox
]

{ #category : #accessing }
FBByFlagsPagePresenter >> modeDropbox: anObject [
	modeDropbox := anObject
]
