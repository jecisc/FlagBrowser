Class {
	#name : #FlagBrowser,
	#superclass : #ComposablePresenter,
	#instVars : [
		'tabs'
	],
	#category : #'FlagBrowser-Spec'
}

{ #category : #specs }
FlagBrowser class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add: #tabs;
		yourself
]

{ #category : #specs }
FlagBrowser class >> example [
	<script>
	self new openWithSpec
]

{ #category : #api }
FlagBrowser >> initialExtent [
	^ (700 @ 500) scaledByDisplayScaleFactor
]

{ #category : #initialization }
FlagBrowser >> initializeWidgets [
	tabs := self newNotebook.

	FBPagePresenter allPages do: [ :aPage | tabs addPage: (NotebookPage title: aPage title icon: (self iconNamed: aPage icon) provider: [ self instantiate: aPage ]) ]
]

{ #category : #initialization }
FlagBrowser >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: 'Flag Browser'
]
