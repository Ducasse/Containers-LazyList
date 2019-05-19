"
I am a lazy list (stream) implementation based on the idea of
SRFI-40 (http://srfi.schemers.org/srfi-40/srfi-40.html).
My element is calculated only when it is necessary, so you can
construct and composite inifinite lists.

I have been originally implemented by Takashi Yamamiya.

LazyList nil ""a sentinel (not singleton)""


A lazy list is a collection where each element is evaluated only when it's necessary. Lazy lists are very useful to express mathematical infinite sequence naturally like all natural numbers, entire prime numbers, or so.
Lazy lists are also practical when you deal with a large sequence of data. Imagine that you want to replace particular words in a large text, and print out just the first 100 characters. Without lazy list, you must either, 1) replace all words and take first 100 characters, or 2) count character position carefully each time when a word is replaced. 1) requires time, and 2) tend to lost modularity. With lazy lists, you can write such program as simple as former way, but performance is still reasonable.



Implementation 

Structure:
 head			Object -- current object
 tail			LazyList -- a pointer for next list
 delay		Block -- a promise which returns a pair of {head. tail}



"
Class {
	#name : #CTLazyList,
	#superclass : #CTList,
	#instVars : [
		'head',
		'tail',
		'delay'
	],
	#classVars : [
		'Nil'
	],
	#category : 'Containers-LazyList'
}

{ #category : #scripts }
CTLazyList class >> constant: x [
	"Return an infinite list of x"

	^ self
		delay: [ {x.
			(self constant: x)} ]
]

{ #category : #'instance creation' }
CTLazyList class >> delay: aBlock [
	"aBlock is a block which answers {anObject. aLazyList}"
	^ self new privateDelay: aBlock
]

{ #category : #examples }
CTLazyList class >> fib [
	"self fib"
	<sampleInstance>
	| fib |
	fib := 1 followedBy: [1 followedBy: [fib + fib next]].
	^ fib
]

{ #category : #scripts }
CTLazyList class >> fib: a with: b [ 
	"self fib: 1 with: 1"
	^ self
		delay: [{a.  self fib: b with: a + b}]
]

{ #category : #'instance creation' }
CTLazyList class >> head: anObject tail: listOrBlock [ 
	^ self
		delay: [{anObject. listOrBlock value}]
]

{ #category : #examples }
CTLazyList class >> helloForever [
	<sampleInstance>
	"(self helloForever take: 50) contentsString"
	^ (self withAll: 'Hello ')
		, [(self withAll: 'World! ')
				, [self helloForever]]
]

{ #category : #'class initialization' }
CTLazyList class >> initialize [
	Nil := self delay: [ nil ]
]

{ #category : #scripts }
CTLazyList class >> nat: n [
	"self nat: 1"
	^ self
		delay: [{n. self nat: n + 1}]
]

{ #category : #accessing }
CTLazyList class >> nil [
	^Nil
]

{ #category : #examples }
CTLazyList class >> pi [
	<sampleInstance>
	"Structure and Interpretation of Computer Programs 3.5.3.
	PI = 4 * (1 - (1/3) + (1/5) - (1/7) + ..."
	"self pi explore"

	| flipFunc flip oddNums summands pi |

	flipFunc := [:n | n followedBy: [(flipFunc value: n) negated]].
	flip := flipFunc value: 1.

	oddNums := 1 followedBy: [oddNums + 2].

	summands := 1 / oddNums * flip.

	pi := summands sums * 4.0.
	^ pi

]

{ #category : #scripts }
CTLazyList class >> position: position velocity: velocity acceleration: acceleration [ 
	"self position: 0 velocity: 1 acceleration: 1"
	^ position
		followedBy: [self
				position: position + velocity
				velocity: velocity + acceleration
				acceleration: acceleration]
]

{ #category : #scripts }
CTLazyList class >> sieve: list [ 
	"self sieve: (self nat: 2)"
	Transcript cr; show: (list take: 10) contents.


	^ list first followedBy: [
			self sieve:
				(list next filter: [:e | e \\ list first ~= 0])]
]

{ #category : #scripts }
CTLazyList class >> watch: aBlock [
	"self watch: [Time now]"
	^ self delay: [{aBlock value. self watch: aBlock}]
]

{ #category : #'instance creation' }
CTLazyList class >> withAll: aCollection [ 
	"self withAll: #(1 2 3 4 5)"
	aCollection isEmpty ifTrue: [^ self nil].
	^ self delay: [ {aCollection first . self withAll: aCollection allButFirst} ]

]

{ #category : #enumerating }
CTLazyList >> , listOrBlock [ 
	"(LazyList withAll: 'He'), [LazyList withAll: 'llo']"
	^ self class
		delay: [self isEmpty
				ifTrue: [listOrBlock value delay value]
				ifFalse: [{self head. self tail , listOrBlock}]]
]

{ #category : #accessing }
CTLazyList >> contentsString [
	| aString index |
	aString := String new: self size.
	index := 1.
	self
		do: [:each | 
			aString at: index put: each.
			index := index + 1].
	^ aString
]

{ #category : #accessing }
CTLazyList >> delay [
	^ delay
		ifNil: [[{head. tail}]]
		ifNotNil: [delay]
]

{ #category : #enumerating }
CTLazyList >> filter: aBlock [ 
	"(self withAll: #(1 2 3 4 5)) filter: [ :e | e odd ]"
	| each |
	^ self class
		delay: [each := self.
			[each isEmpty
				or: [aBlock value: each head]]
				whileFalse: [each := each tail].
			each isEmpty
				ifFalse: [{each head. each tail filter: aBlock}]]
]

{ #category : #accessing }
CTLazyList >> force [
	| pair |
	delay
		ifNil: [^ nil].
	pair := delay value.
	pair
		ifNil: [head := tail := nil]
		ifNotNil: [head := pair first.
			tail := pair second].
	delay := nil
]

{ #category : #accessing }
CTLazyList >> forced [
	^ delay isNil
]

{ #category : #accessing }
CTLazyList >> head [
	self force.
	^ head
]

{ #category : #accessing }
CTLazyList >> isEmpty [
	^ self tail = nil
]

{ #category : #enumerating }
CTLazyList >> map: aBlock [ 
	"self nat map: [ :e | e + 1 ]"
	^ self class
		delay: [self isEmpty
				ifFalse: [{aBlock value: self head. self tail map: aBlock}]]
]

{ #category : #'initialize-release' }
CTLazyList >> privateDelay: aBlock [
	delay := aBlock
]

{ #category : #accessing }
CTLazyList >> tail [
	self force.
	^ tail
]

{ #category : #enumerating }
CTLazyList >> take: n [ 
	n = 0
		ifTrue: [^ self class nil].
	^ self class
		delay: [{self head. (self tail take: n - 1)}]
]

{ #category : #enumerating }
CTLazyList >> whenTrue: list2 whenFalse: list3 [ 
	"Listwize condition. Note: list2 and list3 are lists, not blocks."
	"(self nat map: [:e | e odd]) whenTrue: (self constant: 1) whenFalse: (self constant: 0)"
	^ self class
		delay: [(self isEmpty
					or: [list2 isEmpty
							or: [list3 isEmpty]])
				ifFalse: [
					{self head
						ifTrue: [list2 head]
						ifFalse: [list3 head].
					self tail
						whenTrue: list2 tail
						whenFalse: list3 tail}]]
]

{ #category : #enumerating }
CTLazyList >> with: otherCollection collect: twoArgBlock [ 
	"zipWith function"
	"(self constant: 3) + (self constant: 4)"
	^ self class
		delay: [(self isEmpty
					or: [otherCollection isEmpty])
				ifFalse: [{twoArgBlock value: self head value: otherCollection head. self tail with: otherCollection tail collect: twoArgBlock}]]
]

{ #category : #enumerating }
CTLazyList >> with: list2 with: list3 collect: threeArgBlock [ 
	"zipWith3 function"
	"(self constant: 3) + (self constant: 4)"
	^ self class
		delay: [(self isEmpty
					or: [list2 isEmpty
							or: [list3 isEmpty]])
				ifFalse: [
					{threeArgBlock
						value: self head
						value: list2 head
						value: list3 head.
					self tail
						with: list2 tail
						with: list3 tail
						collect: threeArgBlock}]]
]
