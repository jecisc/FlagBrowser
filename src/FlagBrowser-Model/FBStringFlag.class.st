Class {
	#name : #FBStringFlag,
	#superclass : #FBAbstractFlag,
	#category : #'FlagBrowser-Model'
}

{ #category : #testing }
FBStringFlag class >> matchesArgument: aFlagArgument [
	^ aFlagArgument isString
]

{ #category : #accessing }
FBStringFlag class >> priority [
	^ 10
]
