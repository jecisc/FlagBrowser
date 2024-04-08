"
Description
--------------------

I am a browser allowing one to browse the flags in the system. 

I can organize them in different ways such as flags by flags parameters, flags by class or flags by packages.
"
Class {
	#name : 'StFlagBrowser',
	#superclass : 'SpPresenter',
	#instVars : [
		'tabs'
	],
	#category : 'FlagBrowser-UI',
	#package : 'FlagBrowser',
	#tag : 'UI'
}

{ #category : 'specs' }
StFlagBrowser class >> defaultLayout [
	^ SpBoxLayout newVertical
		add: #tabs;
		yourself
]

{ #category : 'specs' }
StFlagBrowser class >> defaultSpec [

	self flag: #pharo11.
	^ self defaultSpec
]

{ #category : 'world menu' }
StFlagBrowser class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Flags Browser')
		parent: #Browsing;
		order: 3;
		action: [ self open ];
		iconName: #breakpoint;
		help: 'Explore the flags in the system.'
]

{ #category : 'specs' }
StFlagBrowser class >> open [

	<script>
	self flag: #pharo11.
	SystemVersion current major < 11
		ifTrue: [ self new openWithSpec ]
		ifFalse: [ self new open ]
]

{ #category : 'icons' }
StFlagBrowser class >> taskbarIconName [

	^ #breakpoint
]

{ #category : 'initialization' }
StFlagBrowser >> initializeWidgets [
	tabs := self newNotebook.

	StFBPagePresenter allPages
		do: [ :aPage | tabs addPage: (SpNotebookPage title: aPage title icon: (self iconNamed: aPage icon) provider: [ self instantiate: aPage ]) ]
]

{ #category : 'initialization' }
StFlagBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Flags Browser'.
	aWindowPresenter initialExtent: (1000 @ 500) scaledByDisplayScaleFactor
]
