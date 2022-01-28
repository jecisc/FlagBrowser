Extension { #name : #FBLocation }

{ #category : #'*FlagBrowser-Spec-Pharo8' }
FBLocation >> openInBrowser [
	Smalltalk tools browser openOnMethod: self compiledMethod
]
