Class {
	#name : #FBObjectFlag,
	#superclass : #FBAbstractFlag,
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
