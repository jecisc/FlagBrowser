"
I test StFBByClassesPagePresenter: the classes listed as scopes and the locations table columns.
"
Class {
	#name : 'StFBByClassesPagePresenterTest',
	#superclass : 'StFBByScopePagePresenterTest',
	#category : 'FlagBrowser-Tests-UI',
	#package : 'FlagBrowser-Tests',
	#tag : 'UI'
}

{ #category : 'accessing' }
StFBByClassesPagePresenterTest >> knownScopeName [

	^ 'StFBFlagTestFixture'
]

{ #category : 'private' }
StFBByClassesPagePresenterTest >> newPresenter [

	^ StFBByClassesPagePresenter new
]
