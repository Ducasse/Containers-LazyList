"
I am an optimised lazy list for long collection like Stream.

Iterator nil ""a sentinel (not singleton)""

Structure:
 collection			Collection -- current collection
 position			Integer -- current position
 successor			Iterator -- a pointer for next Iterator
 delay				Block -- promis which returns a triplet of {collection, position, successor}
"
Class {
	#name : #CTListIterator,
	#superclass : #CTList,
	#instVars : [
		'collection',
		'position',
		'successor',
		'delay'
	],
	#classVars : [
		'Nil'
	],
	#category : 'Containers-LazyList'
}

{ #category : #'instance creation' }
CTListIterator class >> collection: aCollection position: index successor: anIterator [
	^ self new privateCollection: aCollection position: index successor: anIterator
]

{ #category : #'instance creation' }
CTListIterator class >> delay: aBlock [
	"The primary constructor of Iterator.
	aBlock answers a triplet {aCollection. index. anIterator} or nil."
	^ self new privateDelay: aBlock
]

{ #category : #'instance creation' }
CTListIterator class >> head: anObject tail: listOrBlock [ 
	^ self
		delay: [{{anObject}. 1. listOrBlock value}]
]

{ #category : #examples }
CTListIterator class >> helloForever [
	<sampleInstance>
	"(self helloForever take: 50) contentsString"
	^ (self withAll: 'Hello ')
		, [(self withAll: 'World! ')
				, [self helloForever]]
]

{ #category : #'instance creation' }
CTListIterator class >> initialize [
	Nil := self new.
]

{ #category : #examples }
CTListIterator class >> nat: a [ 
	"(self nat: 1) take: 5"
	^ self delay: [{{a}. 1. self nat: a + 1}]
]

{ #category : #'instance creation' }
CTListIterator class >> nil [
	^Nil
]

{ #category : #'instance creation' }
CTListIterator class >> repeat: aCollection [
	"(self repeat: #(6)) * 7"
	"6 * (self repeat: #(7))"
	^ self
		delay: [{aCollection. 1. self repeat: aCollection}]
]

{ #category : #'instance creation' }
CTListIterator class >> withAll: aCollection [ 
	"BUG: a nil iterator losts the collection flavor (Array, String, etc...)"
	aCollection isEmpty
		ifTrue: [^ self nil].
	^ self
		collection: aCollection
		position: 1
		successor: self nil
]

{ #category : #enumerating }
CTListIterator >> , iteratorOrBlock [ 
	"Append two iterators"
	"(Iterator withAll: 'He'), [Iterator withAll: 'llo']"
	^ self class
		delay: [self isEmpty
				ifTrue: [iteratorOrBlock value delay value]
				ifFalse: [{self collection. self position. self successor, iteratorOrBlock value}]]
]

{ #category : #accessing }
CTListIterator >> at: index [ 
	^ index > self spanSize
		ifTrue: [self successor at: index - self spanSize]
		ifFalse: [self collection at: self position + index - 1]
]

{ #category : #accessing }
CTListIterator >> collection [
	self force.
	^ collection
]

{ #category : #accessing }
CTListIterator >> contents [
	| newCollection index each |
	newCollection := self collection species new: self length.
	index := 1.
	each := self.
	[each isEmpty]
		whileFalse: [newCollection
				replaceFrom: index
				to: index + each spanSize - 1
				with: each collection
				startingAt: each position.
			index := index + each collection size.
			each := each successor].
	^ newCollection
]

{ #category : #accessing }
CTListIterator >> contentsString [
	^ self contents as: String
]

{ #category : #accessing }
CTListIterator >> delay [
	^ delay
		ifNil: [[{collection. position. successor}]]
		ifNotNil: [delay]
]

{ #category : #enumerating }
CTListIterator >> filter: aBlock [ 
	"(self repeat: #(1 2 3 4 5)) filter: [ :e | e odd ]"
	| buffer j newCollection |
	^ self class
		delay: [self isEmpty
				ifTrue: [nil]
				ifFalse: [buffer := self collection species new: self spanSize.
					j := 1.
					self position
						to: self collection size
						do: [:i | (aBlock
									value: (self collection at: i))
								ifTrue: [buffer
										at: j
										put: (self collection at: i).
									j := j + 1]].
					newCollection := buffer copyFrom: 1 to: j - 1.
					newCollection isEmpty
						ifTrue: [(self successor filter: aBlock) delay value]
						ifFalse: [{newCollection. 1. self successor filter: aBlock}]]]
]

{ #category : #accessing }
CTListIterator >> force [
	| triplet |
	delay
		ifNil: [^ nil].
	triplet := delay value.
	triplet
		ifNil: [self
				privateCollection: nil
				position: nil
				successor: nil]
		ifNotNil: [self
				privateCollection: triplet first
				position: triplet second
				successor: triplet third].
	delay := nil
]

{ #category : #accessing }
CTListIterator >> forced [
	^ delay isNil
]

{ #category : #accessing }
CTListIterator >> head [
	^ self collection at: self position
]

{ #category : #accessing }
CTListIterator >> isEmpty [
	^ self successor = nil
]

{ #category : #accessing }
CTListIterator >> length [
	self isEmpty
		ifTrue: [^ 0].
	^ self spanSize + self successor length
]

{ #category : #debugging }
CTListIterator >> longPrintOn: aStream limitedTo: sizeLimit indent: indent [ 
	self longPrintOn: aStream limitedTo: sizeLimit indent: indent index: 1 

]

{ #category : #debugging }
CTListIterator >> longPrintOn: aStream limitedTo: sizeLimit indent: indent index: index [ 
	| title |
	delay
		ifNotNil: [^ aStream nextPutAll: '...'].
	self isEmpty
		ifTrue: [^ self].
	indent
		timesRepeat: [aStream tab].
	aStream nextPutAll: (title := index printString);
		 nextPut: $:;
		 space;
		 tab.
	aStream
		nextPutAll: (self span
				printStringLimitedTo: (sizeLimit - title size max: 1));
		 cr.
	self successor
		longPrintOn: aStream
		limitedTo: sizeLimit
		indent: indent
		index: index + self span size
]

{ #category : #enumerating }
CTListIterator >> map: aBlock [ 
	"(self repeat: #(1 2 3 4 5)) tail map: [ :e | e + 1 ]"
	| newCollection |
	^ self class
		delay: [self isEmpty
				ifTrue: [nil]
				ifFalse: [newCollection := self collection species new: self spanSize.
					self position
						to: self collection size
						do: [:i | newCollection
								at: i - self position + 1
								put: (aBlock
										value: (self collection at: i))].
					{newCollection. 1. self successor map: aBlock}]]
]

{ #category : #accessing }
CTListIterator >> position [
	self force.
	^ position
]

{ #category : #debugging }
CTListIterator >> printElementsOn: aStream [ 
	delay
		ifNotNil: [^ aStream nextPutAll: '...'].
	self isEmpty
		ifTrue: [^ self].
	self span printOn: aStream.
	self successor printElementsOn: aStream
]

{ #category : #debugging }
CTListIterator >> printOn: aStream [ 
	"Append a sequence of characters that identify the receiver to aStream."

	self printNameOn: aStream.
	aStream space.
	self printElementsOn: aStream
]

{ #category : #debugging }
CTListIterator >> printStringLimitedTo: limit [
	"Answer a String whose characters are a description of the receiver.
	If you want to print without a character limit, use fullPrintString."
	| limitedString |
	limitedString _ String streamContents: [:s | self printOn: s] limitedTo: limit.
	limitedString size < limit ifTrue: [^ limitedString].
	^ limitedString , '...etc...'
]

{ #category : #'initialize-release' }
CTListIterator >> privateCollection: aCollection position: index successor: anIterator [ 
	collection := aCollection.
	position := index.
	successor := anIterator
]

{ #category : #'initialize-release' }
CTListIterator >> privateDelay: aBlock [
	delay := aBlock
]

{ #category : #accessing }
CTListIterator >> repeat: aNumber [ 
	"'yey ' iterator repeat: 10"
	^ aNumber = 0
		ifTrue: [self class nil]
		ifFalse: [self
				, [self repeat: aNumber - 1]]
]

{ #category : #accessing }
CTListIterator >> span [
	^ self collection copyFrom: self position to: self collection size
]

{ #category : #accessing }
CTListIterator >> spanSize [
	^ self collection size - self position + 1
]

{ #category : #accessing }
CTListIterator >> successor [
	self force.
	^ successor
]

{ #category : #accessing }
CTListIterator >> tail [
	^ self position = self collection size
		ifTrue: [self successor]
		ifFalse: [self class
				collection: self collection
				position: self position + 1
				successor: self successor]
]

{ #category : #enumerating }
CTListIterator >> take: aNumber [ 
	"((self repeat: 'hello ') take: 100) contents"
	"('hello' iterator take: 3) contents"
	^ self class
		delay: [(aNumber = 0
					or: [self isEmpty])
				ifFalse: [aNumber >= self spanSize
						ifTrue: [{collection. position. self successor take: aNumber - self spanSize}]
						ifFalse: [{collection first: aNumber. 1. self class nil}]]]
]

{ #category : #enumerating }
CTListIterator >> with: otherCollection collect: twoArgBlock [ 
	"zipWith function.
	BUG: it assumes receiver and otherCollection is same size."
	"(self repeat: #(1 2 3)) + (self repeat: #(1 1))"
	"(self repeat: #(1 2 3)) + ((self repeat: #(1 1)) take: 10)"
	| newCollection other |
	self isEmpty
		ifTrue: [^ self].
	otherCollection isEmpty
		ifTrue: [^ self].
	other := otherCollection.
	^ self class
		delay: [newCollection := collection species new: self spanSize.
			position
				to: collection size
				do: [:i | 
					newCollection
						at: i - position + 1
						put: (twoArgBlock
								value: (collection at: i)
								value: other head).
					other := other tail].
			{newCollection. 1. successor with: other collect: twoArgBlock}]
]
