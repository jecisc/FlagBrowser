"
Description
--------------------

I represent a flag which parameter is an Object.
"
Class {
	#name : #FBObjectFlag,
	#superclass : #FBFlag,
	#category : #'FlagBrowser-Model'
}

{ #category : #testing }
FBObjectFlag class >> matchesArgument: aFlagArgument [
	^ true
]

{ #category : #accessing }
FBObjectFlag class >> priority [
	^ 0
]

{ #category : #accessing }
FBObjectFlag >> insensitiveParameter [
	"Do nothing for objects."
]
