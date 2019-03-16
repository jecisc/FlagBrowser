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

{ #category : #initialization }
FlagBrowser >> classesPage [
	^ NotebookPage title: 'By class' icon: (self iconNamed: #class) provider: [ self instantiate: FBPagePresenter ]
]

{ #category : #initialization }
FlagBrowser >> flagsPage [
	^ NotebookPage title: 'By flag' icon: (self iconNamed: #changeUpdate) provider: [ self instantiate: FBPagePresenter ]
]

{ #category : #api }
FlagBrowser >> initialExtent [
	^ (700 @ 500) scaledByDisplayScaleFactor
]

{ #category : #initialization }
FlagBrowser >> initializeWidgets [
	tabs := self newNotebook.

	tabs
		addPage: self flagsPage;
		addPage: self packagesPage;
		addPage: self classesPage
]

{ #category : #initialization }
FlagBrowser >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: 'Flag Browser'
]

{ #category : #initialization }
FlagBrowser >> packagesPage [
	^ NotebookPage title: 'By package' icon: (self iconNamed: #package) provider: [ self instantiate: FBPagePresenter ]
]
