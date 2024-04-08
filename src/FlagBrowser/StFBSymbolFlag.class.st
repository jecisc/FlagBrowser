"
Description
--------------------

I represent a flag which parameter is a Symbol.
"
Class {
	#name : 'StFBSymbolFlag',
	#superclass : 'StFBFlag',
	#category : 'FlagBrowser-Model',
	#package : 'FlagBrowser',
	#tag : 'Model'
}

{ #category : 'testing' }
StFBSymbolFlag class >> matchesArgument: aFlagArgument [
	^ aFlagArgument isSymbol
]

{ #category : 'accessing' }
StFBSymbolFlag class >> priority [
	^ 20
]

{ #category : '*FlagBrowser-UI' }
StFBSymbolFlag class >> title [
	^ 'Symbol flags'
]

{ #category : 'accessing' }
StFBSymbolFlag >> insensitiveParameter [
	self parameter: self parameter asLowercase capitalized asSymbol
]
