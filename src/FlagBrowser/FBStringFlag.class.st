"
Description
--------------------

I represent a flag which parameter is a String.
"
Class {
	#name : 'FBStringFlag',
	#superclass : 'FBFlag',
	#category : 'FlagBrowser-Model',
	#package : 'FlagBrowser',
	#tag : 'Model'
}

{ #category : 'testing' }
FBStringFlag class >> matchesArgument: aFlagArgument [
	^ aFlagArgument isString
]

{ #category : 'accessing' }
FBStringFlag class >> priority [
	^ 10
]

{ #category : '*FlagBrowser-UI' }
FBStringFlag class >> title [
	^ 'String flags'
]

{ #category : 'accessing' }
FBStringFlag >> insensitiveParameter [
	self parameter: self parameter asLowercase capitalized
]
