"
Description
--------------------

I represent a flag which parameter is a String.
"
Class {
	#name : 'StFBStringFlag',
	#superclass : 'StFBFlag',
	#category : 'FlagBrowser-Model',
	#package : 'FlagBrowser',
	#tag : 'Model'
}

{ #category : 'testing' }
StFBStringFlag class >> matchesArgument: aFlagArgument [
	^ aFlagArgument isString
]

{ #category : 'accessing' }
StFBStringFlag class >> priority [
	^ 10
]

{ #category : '*FlagBrowser-UI' }
StFBStringFlag class >> title [
	^ 'String flags'
]

{ #category : 'accessing' }
StFBStringFlag >> insensitiveParameter [
	self parameter: self parameter asLowercase capitalized
]
