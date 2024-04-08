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
	#name : 'FBPagePresenter',
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
FBPagePresenter class >> allPages [
	^ (self allSubclasses reject: #isAbstract) sorted: #priority ascending
]

{ #category : 'specs' }
FBPagePresenter class >> icon [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
FBPagePresenter class >> priority [
	^ self subclassResponsibility
]

{ #category : 'specs' }
FBPagePresenter class >> title [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
FBPagePresenter >> code [
	^ code
]

{ #category : 'accessing' }
FBPagePresenter >> code: anObject [
	code := anObject
]

{ #category : 'initialization' }
FBPagePresenter >> connectPresenters [

	code whenSubmitDo: [ :text | code behavior compile: text ].

	locationsTable whenSelectionChangedDo: [ :selection | [ :location | self selectLocation: location ] cull: selection selectedItem ].

	"We want to refresh the method pane if we edited the currently selected method in another tool."
	self class codeChangeAnnouncer weak when: MethodAnnouncement send: #methodAnnouncementReceived: to: self
]

{ #category : 'finalization' }
FBPagePresenter >> finalize [
	"We subscribe to method announcements to refresh them when a change happens. Here we make sure we unsubscribe ourselves."

	self class codeChangeAnnouncer unsubscribe: self
]

{ #category : 'initialization' }
FBPagePresenter >> initializeWidgets [
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
FBPagePresenter >> locationsTable [
	^ locationsTable
]

{ #category : 'accessing' }
FBPagePresenter >> locationsTable: anObject [
	locationsTable := anObject
]

{ #category : 'instance creation' }
FBPagePresenter >> methodAnnouncementReceived: anAnnouncement [
	"No need to rebuild if it contains the world menu pragma"

	anAnnouncement methodAffected name = self locationsTable selectedItem compiledMethod name ifTrue: [ self selectLocation: self locationsTable selectedItem ]
]

{ #category : 'initialization' }
FBPagePresenter >> selectLocation: location [

	location ifNil: [ ^ self code ].

	^ self code
		  text: location sourceCode;
		  beForMethod: location compiledMethod;
		  selectionInterval: location interval
]

{ #category : 'initialization' }
FBPagePresenter >> tableMenu [
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
