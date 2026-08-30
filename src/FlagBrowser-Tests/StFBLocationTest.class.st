"
I am a test class to test StFBLocation.
"
Class {
	#name : 'StFBLocationTest',
	#superclass : 'TestCase',
	#category : 'FlagBrowser-Tests-Model',
	#package : 'FlagBrowser-Tests',
	#tag : 'Model'
}

{ #category : 'helpers' }
StFBLocationTest >> location [

	^ StFBLocation class: Point selector: #x interval: (1 to: 2)
]

{ #category : 'tests' }
StFBLocationTest >> testCompiledMethod [

	self assert: self location compiledMethod equals: Point >> #x
]

{ #category : 'tests' }
StFBLocationTest >> testEquality [

	| other |
	other := StFBLocation class: Point selector: #x interval: (1 to: 2).
	self assert: self location equals: other.
	self assert: self location equals: self location copy
]

{ #category : 'tests' }
StFBLocationTest >> testHash [

	| other |
	other := StFBLocation class: Point selector: #x interval: (1 to: 2).
	self assert: self location hash equals: other hash
]

{ #category : 'tests' }
StFBLocationTest >> testPackage [

	| location |
	location := self location.
	self assert: location package equals: (Point >> #x) package
]

{ #category : 'tests' }
StFBLocationTest >> testPackageName [

	| location |
	location := self location.
	self assert: location packageName equals: (Point >> #x) package name
]

{ #category : 'tests' }
StFBLocationTest >> testSourceCode [

	| location |
	location := self location.
	self assert: location sourceCode equals: location compiledMethod sourceCode
]
