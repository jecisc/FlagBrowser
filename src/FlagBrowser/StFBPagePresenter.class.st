"
Description
--------------------

I represent a tab of the FlagBrowser. 

We different subclasses will organize flags in different ways.

Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	code:					<aTextPresenter>		A text presenter to show the source code of the method containing the flag.
	locationsTable:		<aTablePresenter>		A table presenter to show the different locations to highlight to the user depending on the page organization.

"
Class {
	#name : 'StFBPagePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'code',
		'locationsTable',
		'showPharoFlagsCheckbox'
	],
	#category : 'FlagBrowser-UI',
	#package : 'FlagBrowser',
	#tag : 'UI'
}

{ #category : 'accessing' }
StFBPagePresenter class >> allPages [
	^ (self allSubclasses reject: #isAbstract) sorted: #priority ascending
]

{ #category : 'specs' }
StFBPagePresenter class >> icon [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
StFBPagePresenter class >> priority [
	^ self subclassResponsibility
]

{ #category : 'specs' }
StFBPagePresenter class >> title [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
StFBPagePresenter >> code [
	^ code
]

{ #category : 'accessing' }
StFBPagePresenter >> code: anObject [
	code := anObject
]

{ #category : 'initialization' }
StFBPagePresenter >> connectPresenters [

	code whenSubmitDo: [ :text | code behavior compile: text ].

	locationsTable whenSelectionChangedDo: [ :selection | [ :location | self selectLocation: location ] cull: selection selectedItem ].

	showPharoFlagsCheckbox whenChangedDo: [ :value |
			StFBFlag showPharoFlags: value.
			self refresh ].

	"We want to refresh the method pane if we edited the currently selected method in another tool."
	self class codeChangeAnnouncer weak when: MethodAnnouncement send: #refresh to: self
]

{ #category : 'initialization' }
StFBPagePresenter >> initializePresenters [

	super initializePresenters.
	locationsTable := self newTable.
	code := self newCode.
	showPharoFlagsCheckbox := self newCheckBox.

	locationsTable
		beResizable;
		activateOnDoubleClick;
		whenActivatedDo: [ :selection | selection selectedItem openInBrowser ];
		contextMenu: self tableMenu.

	code syntaxHighlight: true.

	showPharoFlagsCheckbox
		label: 'Show Pharo''s flags';
		state: self showPharoFlags
]

{ #category : 'accessing' }
StFBPagePresenter >> locationsTable [
	^ locationsTable
]

{ #category : 'accessing' }
StFBPagePresenter >> locationsTable: anObject [
	locationsTable := anObject
]

{ #category : 'accessing' }
StFBPagePresenter >> refresh [

	self subclassResponsibility
]

{ #category : 'initialization' }
StFBPagePresenter >> selectLocation: location [

	location ifNil: [ ^ self code ].

	^ self code
		  text: location sourceCode;
		  beForMethod: location compiledMethod;
		  selectionInterval: location interval
]

{ #category : 'testing' }
StFBPagePresenter >> showPharoFlags [

	^ StFBFlag showPharoFlags
]

{ #category : 'initialization' }
StFBPagePresenter >> tableMenu [
	| aMenu |
	aMenu := SpMenuPresenter new.

	aMenu
		addGroup: [ :aGroup | 
			aGroup
				addItem: [ :anItem | 
					anItem
						name: 'Browse';
						icon: (self iconNamed: #smallFind);
						action: [ :param | self locationsTable selectedItem openInBrowser ] ] ].

	^ aMenu
]
