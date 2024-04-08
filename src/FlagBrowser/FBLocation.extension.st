Extension { #name : 'FBLocation' }

{ #category : '*FlagBrowser-UI' }
FBLocation >> openInBrowser [
	Smalltalk tools browser openOnMethod: self compiledMethod
]
