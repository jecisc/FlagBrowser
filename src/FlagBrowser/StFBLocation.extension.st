Extension { #name : 'StFBLocation' }

{ #category : '*FlagBrowser-UI' }
StFBLocation >> openInBrowser [
	Smalltalk tools browser openOnMethod: self compiledMethod
]
