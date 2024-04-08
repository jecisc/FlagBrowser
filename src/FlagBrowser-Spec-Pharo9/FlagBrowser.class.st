"
Description
--------------------

I am a browser allowing one to browse the flags in the system. 

I can organize them in different ways such as flags by flags parameters, flags by class or flags by packages.
"
Class {
	#name : 'FlagBrowser',
	#superclass : 'SpPresenter',
	#instVars : [
		'tabs'
	],
	#category : 'FlagBrowser-Spec-Pharo9',
	#package : 'FlagBrowser-Spec-Pharo9'
}

{ #category : 'specs' }
FlagBrowser class >> defaultLayout [
	^ SpBoxLayout newVertical
		add: #tabs;
		yourself
]

{ #category : 'specs' }
FlagBrowser class >> defaultSpec [
	self flag: #pharo11.
	^ SpBoxLayout newVertical
		add: #tabs;
		yourself
]

{ #category : 'world menu' }
FlagBrowser class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Flags Browser')
		parent: #'New Tools';
		order: 20;
		action: [ self open ];
		iconName: #breakpoint;
		help: 'Explore the flags in the system.';
		withSeparatorAfter 
]

{ #category : 'specs' }
FlagBrowser class >> open [

	<script>
	self flag: #pharo11.
	SystemVersion current major < 11
		ifTrue: [ self new openWithSpec ]
		ifFalse: [ self new open ]
]

{ #category : 'icons' }
FlagBrowser class >> taskbarIconName [

	^ #breakpoint
]

{ #category : 'initialization' }
FlagBrowser >> initializeWidgets [
	tabs := self newNotebook.

	FBPagePresenter allPages
		do: [ :aPage | tabs addPage: (SpNotebookPage title: aPage title icon: (self iconNamed: aPage icon) provider: [ self instantiate: aPage ]) ]
]

{ #category : 'initialization' }
FlagBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Flags Browser'.
	aWindowPresenter initialExtent: (1000 @ 500) scaledByDisplayScaleFactor
]
