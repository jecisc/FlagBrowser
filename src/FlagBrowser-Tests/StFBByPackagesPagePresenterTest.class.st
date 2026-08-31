"
I test StFBByPackagesPagePresenter: the packages listed as scopes and the locations table columns.
"
Class {
	#name : 'StFBByPackagesPagePresenterTest',
	#superclass : 'StFBByScopePagePresenterTest',
	#category : 'FlagBrowser-Tests-UI',
	#package : 'FlagBrowser-Tests',
	#tag : 'UI'
}

{ #category : 'accessing' }
StFBByPackagesPagePresenterTest >> knownScopeName [

	^ 'FlagBrowser-Tests'
]

{ #category : 'private' }
StFBByPackagesPagePresenterTest >> newPresenter [

	^ StFBByPackagesPagePresenter new
]
