Extension { #name : 'CompiledMethod' }

{ #category : '*FlagBrowser' }
CompiledMethod >> flagNodes [

	^ self ast allChildren select: [ :child | child isMessage and: [ child selector = #flag: ] ]
]
