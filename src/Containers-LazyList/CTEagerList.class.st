"
I am a simple lisp style eager list made of cons cell.
I exist as a reference implementation of list protocol.

EagerList nil ""singleton sentinel""

Structure:
 head		Object -- current object (CAR).
 tail		EagerList -- next list (CDR).

"
Class {
	#name : #CTEagerList,
	#superclass : #CTList,
	#instVars : [
		'head',
		'tail'
	],
	#classVars : [
		'Nil'
	],
	#category : 'Containers-LazyList'
}

{ #category : #'instance creation' }
CTEagerList class >> head: anObject tail: aList [ 
	^ self new privateHead: anObject tail: aList
]

{ #category : #accessing }
CTEagerList class >> initialize [
	Nil := self new.
]

{ #category : #accessing }
CTEagerList class >> nil [
	^Nil
]

{ #category : #'instance creation' }
CTEagerList class >> withAll: aCollection [ 
	"self withAll: #(1 2 3 4 5)"
	^ aCollection reverse
		inject: self nil
		into: [:tail :head | self head: head tail: tail]
]

{ #category : #accessing }
CTEagerList >> head [
	^ head
]

{ #category : #initialization }
CTEagerList >> privateHead: anObject tail: aList [
	"Private. Use EagerList class>>head:tail: to make an instance."
	head := anObject.
	tail := aList
]

{ #category : #accessing }
CTEagerList >> tail [
	^ tail
]
