"
I test the tabs of StFlagBrowser.
"
Class {
	#name : 'StFlagBrowserTest',
	#superclass : 'TestCase',
	#category : 'FlagBrowser-Tests-UI',
	#package : 'FlagBrowser-Tests',
	#tag : 'UI'
}

{ #category : 'tests' }
StFlagBrowserTest >> testAllPagesReturnsConcretePagesInPriorityOrder [

	| pages |
	pages := StFBPagePresenter allPages.

	self assert: pages asArray equals: {
			StFBByFlagsPagePresenter.
			StFBByPackagesPagePresenter.
			StFBByClassesPagePresenter }.
	self assert: (pages collect: #priority) asArray equals: #( 1 5 10 )
]
