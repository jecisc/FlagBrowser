"
Description
--------------------

I represent a flag location. The location is the method in which it was defined. 

I am used by FBFlag.
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	classLocation:		<aClass>			Class of the compiled method containing the flag.
	flag:					<aFlag>			Flag which is present at this location.
	interval:				<anInterval>		Interval in the code where the flag is.
	selector:				<aSelector>		Selector of the compiled method containing the flag.

"
Class {
	#name : 'StFBLocation',
	#superclass : 'Object',
	#instVars : [
		'classLocation',
		'selector',
		'interval',
		'flag'
	],
	#category : 'FlagBrowser-Model',
	#package : 'FlagBrowser',
	#tag : 'Model'
}

{ #category : 'instance creation' }
StFBLocation class >> class: aClass selector: aMethodSelector interval: anInterval [
	^ self new
		classLocation: aClass;
		selector: aMethodSelector;
		interval: anInterval;
		yourself
]

{ #category : 'comparing' }
StFBLocation >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ selector = anObject selector and: [ classLocation = anObject classLocation and: [ interval = anObject interval ] ]
]

{ #category : 'accessing' }
StFBLocation >> classLocation [
	^ classLocation
]

{ #category : 'accessing' }
StFBLocation >> classLocation: anObject [
	classLocation := anObject
]

{ #category : 'accessing' }
StFBLocation >> compiledMethod [
	^ self classLocation >> self selector
]

{ #category : 'accessing' }
StFBLocation >> flag [
	^ flag
]

{ #category : 'accessing' }
StFBLocation >> flag: aFlag [
	flag := aFlag
]

{ #category : 'comparing' }
StFBLocation >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ selector hash bitXor: (classLocation hash bitXor: interval hash)
]

{ #category : 'accessing' }
StFBLocation >> interval [
	^ interval
]

{ #category : 'accessing' }
StFBLocation >> interval: anObject [
	interval := anObject
]

{ #category : '*FlagBrowser-UI' }
StFBLocation >> openInBrowser [
	Smalltalk tools browser openOnMethod: self compiledMethod
]

{ #category : 'accessing' }
StFBLocation >> package [
	^ self compiledMethod package
]

{ #category : 'accessing' }
StFBLocation >> packageName [

	^ self package name
]

{ #category : 'accessing' }
StFBLocation >> selector [
	^ selector
]

{ #category : 'accessing' }
StFBLocation >> selector: anObject [
	selector := anObject
]

{ #category : 'accessing' }
StFBLocation >> sourceCode [
	^ self compiledMethod sourceCode
]
