"
Description
--------------------

I represent a flag which parameter is an Object.
"
Class {
	#name : 'StFBObjectFlag',
	#superclass : 'StFBFlag',
	#category : 'FlagBrowser-Model',
	#package : 'FlagBrowser',
	#tag : 'Model'
}

{ #category : 'testing' }
StFBObjectFlag class >> matchesArgument: aFlagArgument [
	^ true
]

{ #category : 'accessing' }
StFBObjectFlag class >> priority [
	^ 0
]

{ #category : 'accessing' }
StFBObjectFlag class >> title [
	^ 'Object flags'
]

{ #category : 'accessing' }
StFBObjectFlag >> insensitiveParameter [
	"Do nothing for objects."
]
