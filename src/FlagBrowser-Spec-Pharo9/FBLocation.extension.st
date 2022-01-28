Extension { #name : #FBLocation }

{ #category : #'*FlagBrowser-Spec-Pharo9' }
FBLocation >> openInBrowser [
	Smalltalk tools browser openOnMethod: self compiledMethod
]
