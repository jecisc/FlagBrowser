"
I am a test class to test the three StFBFlag subclasses: StFBSymbolFlag, StFBStringFlag and StFBObjectFlag.
"
Class {
	#name : 'StFBSpecificFlagsTest',
	#superclass : 'TestCase',
	#category : 'FlagBrowser-Tests-Model',
	#package : 'FlagBrowser-Tests',
	#tag : 'Model'
}

{ #category : 'tests' }
StFBSpecificFlagsTest >> testObjectInsensitiveParameterDoesNothing [

	| flag |
	flag := StFBObjectFlag new.
	flag parameter: 42.
	flag insensitiveParameter.
	self assert: flag parameter equals: 42
]

{ #category : 'tests' }
StFBSpecificFlagsTest >> testStringInsensitiveParameter [

	| flag |
	flag := StFBStringFlag new.
	flag parameter: 'Pharo Flag'.
	flag insensitiveParameter.
	self assert: flag parameter equals: 'Pharo flag'
]

{ #category : 'tests' }
StFBSpecificFlagsTest >> testStringMatchesString [

	self assert: (StFBStringFlag matchesArgument: 'foo').
	self deny: (StFBStringFlag matchesArgument: 42)
]

{ #category : 'tests' }
StFBSpecificFlagsTest >> testSymbolInsensitiveParameter [

	| flag |
	flag := StFBSymbolFlag new.
	flag parameter: #PharoFlag.
	flag insensitiveParameter.
	self assert: flag parameter equals: #Pharoflag
]

{ #category : 'tests' }
StFBSpecificFlagsTest >> testSymbolMatchesSymbol [

	self assert: (StFBSymbolFlag matchesArgument: #foo).
	self deny: (StFBSymbolFlag matchesArgument: 'foo').
	self deny: (StFBSymbolFlag matchesArgument: 42)
]
