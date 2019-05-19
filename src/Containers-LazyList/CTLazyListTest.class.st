"
self buildSuite run
"
Class {
	#name : #CTLazyListTest,
	#superclass : #TestCase,
	#category : 'Containers-LazyList'
}

{ #category : #testing }
CTLazyListTest >> testContentsString [
	"self debug: #testString"
	self assert: (CTLazyList withAll: 'Hello') contentsString = 'Hello'.
	self assert: (CTLazyList head: $H tail: [CTLazyList withAll: 'ello']) contentsString = 'Hello'.
	self assert: (CTLazyList head: $H tail: (CTLazyList withAll: 'ello')) contentsString = 'Hello'.

	self assert: ((CTLazyList withAll: 'He'), [CTLazyList withAll: 'llo']) contentsString = 'Hello'.
	self assert: ((CTLazyList withAll: 'He'), (CTLazyList withAll: 'llo')) contentsString = 'Hello'.

]

{ #category : #testing }
CTLazyListTest >> testEmpty [

	self assert: (CTLazyList new isEmpty).
	self assert: (CTLazyList withAll: #()) isEmpty.
	self deny: (CTLazyList withAll: #(1 2)) isEmpty
]

{ #category : #testing }
CTLazyListTest >> testFollowed [
	"self run: #testFollowed"
	| ll |
	ll := 1 followedBy: (2 followedBy: (3 followedBy: CTLazyList nil)).
	self assert: ll class = CTLazyList
]

{ #category : #testing }
CTLazyListTest >> testIteratorBasic [
	"self debug: #testIteratorBasic"
	self assert: (CTListIterator head: 1 tail: CTListIterator nil) contents = #(1).
	self assert: (CTListIterator head: 1 tail: [CTListIterator nil]) contents = #(1).

	self assert: (CTListIterator withAll: #()) isEmpty.
	self assert: (CTListIterator withAll: #(1 2 3 4 5)) head = 1.
	self assert: (CTListIterator withAll: #(1 2 3 4 5)) tail length = 4.
	self assert: ((CTListIterator withAll: #(1 2 3 4 5)) tail at: 2) = 3.
	self assert: (((CTListIterator withAll: #(1 2)),  (CTListIterator withAll: #(3 4 5))) tail at: 3) = 4.
	self assert: (CTListIterator withAll: #(1 2 3 4 5)) tail contents = #(2 3 4 5).


]

{ #category : #testing }
CTLazyListTest >> testIteratorEnumerating [
	"self debug: #testIteratorEnumerating"

	self assert: ((CTListIterator withAll: #(1 2 3)) map: [ :e | e + 1 ]) contents = #(2 3 4).
	self assert: (((CTListIterator repeat: #(1 2 3)) filter: [ :e | e \\ 2 = 1 ]) take: 3) contents = #(1 3 1).

	self assert: ((CTListIterator withAll: #(2 3 4)) foldl: 1 do: [:h :t | h - t]) = -8.
	self assert: ((CTListIterator withAll: #(1 2 3)) foldr: 4 do: [:h :t | h - t]) = -2.

	self assert: ((CTListIterator nat: 1) take: 5) contents = #(1 2 3 4 5).
	self assert: ((((CTListIterator withAll: #(2 1)), (CTListIterator withAll: #(0))) map: [ :e | 1 / e ]) take: 2) contents =  {1/2. 1}.

	self assert: (((CTListIterator nat: 1) map: [ :e | e + 1 ]) take: 5) contents = #(2 3 4 5 6).
	self assert: (((CTListIterator nat: 1) filter: [ :e | e odd ]) take: 5) contents = #(1 3 5 7 9).
	self assert: ((CTListIterator withAll: #(1 2 3)) + 1) contents = #(2 3 4).
	self assert: ((CTListIterator withAll: #(1 2 3)) + (CTListIterator repeat: #(1))) contents = #(2 3 4).

]

{ #category : #testing }
CTLazyListTest >> testIteratorString [
	"self debug: #testIteratorString"
	self assert: (CTListIterator withAll: 'Hello') contents = 'Hello'.
	self assert: (CTListIterator head: $H tail: [CTListIterator withAll: 'ello']) contentsString = 'Hello'.
	self assert: (CTListIterator head: $H tail: (CTListIterator withAll: 'ello')) contentsString = 'Hello'.

	self assert: ((CTListIterator withAll: 'He'), [CTListIterator withAll: 'llo']) contents = 'Hello'.
	self assert: ((CTListIterator withAll: 'He'), (CTListIterator withAll: 'llo')) contents = 'Hello'.

	self assert: ((CTListIterator withAll: 'He'),
				(CTListIterator withAll: 'l'),
				(CTListIterator withAll: 'lo')) contents = 'Hello'.

]

{ #category : #testing }
CTLazyListTest >> testLazyBasic [
	"self debug: #testLazyBasic"
	self assert: (CTLazyList head: 1 tail: CTLazyList nil) contents = #(1).
	self assert: (CTLazyList head: 1 tail: [CTLazyList nil]) contents = #(1).
	self assert: (CTLazyList delay: [{1. CTLazyList nil}]) contents = #(1).

	self assert: (CTLazyList withAll: #()) isEmpty.
	self assert: (CTLazyList withAll: #(1 2 3 4 5)) head = 1.
	self assert: (CTLazyList withAll: #(1 2 3 4 5)) tail length = 4.
	self assert: ((CTLazyList withAll: #(1 2 3 4 5)) tail at: 2) = 3.
	self assert: (CTLazyList withAll: #(1 2 3 4 5)) tail contents = #(2 3 4 5).

	self assert: CTLazyList nat head = 1.
	self assert: (CTLazyList nat tail take: 4) length = 4.
	self assert: (CTLazyList nat tail at: 2) = 3.
	self assert: (CTLazyList nat tail take: 4) contents = #(2 3 4 5).

]

{ #category : #testing }
CTLazyListTest >> testLazyEnumerating [
	"self debug: #testLazyEnumerating"

	self assert: ((CTLazyList nat map: [ :e | e + 1 ]) take: 3) contents = #(2 3 4).
	self assert: ((CTLazyList nat filter: [ :e | e \\ 2 = 0 ]) take: 3) contents = #(2 4 6).
	self assert: ((CTLazyList withAll: #(2 3 4)) foldl: 1 do: [:h :t | h - t]) = -8.
	self assert: ((CTLazyList withAll: #(1 2 3)) foldr: 4 do: [:h :t | h - t]) = -2.

	self assert: (CTLazyList nat take: 5) contents = #(1 2 3 4 5).
	self assert: (((CTLazyList withAll: #(2 1 0)) map: [ :e | 1 / e ]) take: 2) contents =  {1/2. 1}.

	self assert: ((CTLazyList nat + 1) take: 3) contents = #(2 3 4).
	self assert: ((CTLazyList withAll: #(1 2 3)) + (CTLazyList constant: 1)) contents = #(2 3 4).

]

{ #category : #testing }
CTLazyListTest >> testLazyPrint [
	"self debug: #testLazyPrint"
	self assert: (CTLazyList withAll: #()) show contents equals: 'CTLazyList nil'.
	self assert: (CTLazyList delay: []) show contents equals: 'CTLazyList ..'.
	self assert: (CTLazyList withAll: #(1)) force show contents equals: 'CTLazyList 1'.
	self assert: (CTLazyList withAll: #(1 2)) force show contents equals: 'CTLazyList 1 ..'.
	self assert: (CTLazyList withAll: #(1 2 3)) force show contents equals: 'CTLazyList 1 ..'.

]

{ #category : #testing }
CTLazyListTest >> testMap [

	|ll|
	ll := (CTLazyList withAll: #(1 2 3 4 5)) map: [ :e | e + 1 ].
	self assert: ll head equals: 2.
	self assert: ll tail head equals: 3
]

{ #category : #testing }
CTLazyListTest >> testString [
	"self debug: #testString"
	self assert: (CTLazyList withAll: 'Hello') contentsString = 'Hello'.
	self assert: (CTLazyList head: $H tail: [CTLazyList withAll: 'ello']) contentsString = 'Hello'.
	self assert: (CTLazyList head: $H tail: (CTLazyList withAll: 'ello')) contentsString = 'Hello'.

	self assert: ((CTLazyList withAll: 'He'), [CTLazyList withAll: 'llo']) contentsString = 'Hello'.
	self assert: ((CTLazyList withAll: 'He'), (CTLazyList withAll: 'llo')) contentsString = 'Hello'.

]

{ #category : #testing }
CTLazyListTest >> testnat [

	| ll |
	ll := (CTLazyList nat map: [:e | e odd]).
	self assert: ll head equals: true.
	self assert: ll tail head equals: false.
	self assert: ll tail tail head equals: true.
]

{ #category : #testing }
CTLazyListTest >> testwhenTruewhenFalse [
	| ll |
	ll := (CTLazyList nat map: [:e | e odd]) 
				whenTrue: (CTLazyList constant: 1) 
				whenFalse: (CTLazyList constant: 0).
	
	self assert: ll head equals: 1.
	self assert: ll tail head equals: 0.
	self assert: ll tail tail head equals: 1.
	
]
