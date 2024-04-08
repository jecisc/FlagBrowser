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
		'locationsTable'
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

	"We want to refresh the method pane if we edited the currently selected method in another tool."
	self class codeChangeAnnouncer weak when: MethodAnnouncement send: #methodAnnouncementReceived: to: self
]

{ #category : 'finalization' }
StFBPagePresenter >> finalize [
	"We subscribe to method announcements to refresh them when a change happens. Here we make sure we unsubscribe ourselves."

	self class codeChangeAnnouncer unsubscribe: self
]

{ #category : 'initialization' }
StFBPagePresenter >> initializeWidgets [
	locationsTable := self newTable.
	code := self newCode.

	locationsTable
		beResizable;
		activateOnDoubleClick;
		whenActivatedDo: [ :selection | selection selectedItem openInBrowser ];
		contextMenu: self tableMenu.

	code syntaxHighlight: true
]

{ #category : 'accessing' }
StFBPagePresenter >> locationsTable [
	^ locationsTable
]

{ #category : 'accessing' }
StFBPagePresenter >> locationsTable: anObject [
	locationsTable := anObject
]

{ #category : 'instance creation' }
StFBPagePresenter >> methodAnnouncementReceived: anAnnouncement [
	"No need to rebuild if it contains the world menu pragma"

	anAnnouncement methodAffected name = self locationsTable selectedItem compiledMethod name ifTrue: [ self selectLocation: self locationsTable selectedItem ]
]

{ #category : 'initialization' }
StFBPagePresenter >> selectLocation: location [

	location ifNil: [ ^ self code ].

	^ self code
		  text: location sourceCode;
		  beForMethod: location compiledMethod;
		  selectionInterval: location interval
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
