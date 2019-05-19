"
I am abstract class for functional lazy / eager collection.

It is unclear if I should be a subclass of Collection since I do not support certain API such as add: 
"
Class {
	#name : #CTList,
	#superclass : #Collection,
	#category : #'Containers-LazyList'
}

{ #category : #examples }
CTList class >> nat [
	"CTLazyList nat"
	"CTListIterator nat"

	| nat |
	nat := self head: 1 tail: [ nat + 1 ].
	^ nat
]

{ #category : #accessing }
CTList class >> nil [
	^nil
]

{ #category : #enumerating }
CTList >> , ys [ 
	^ self
		foldr: ys
		do: [:x :xs | self class head: x tail: xs]
]

{ #category : #arithmetic }
CTList >> < arg [

	^ arg adaptToCollection: self andSend: #<
]

{ #category : #testing }
CTList >> = anObject [ 
	"Equality is not easy because it can be infinite length."
	^self == anObject
]

{ #category : #arithmetic }
CTList >> > arg [

	^ arg adaptToCollection: self andSend: #>
]

{ #category : #arithmetic }
CTList >> @ arg [

	^ arg adaptToCollection: self andSend: #@
]

{ #category : #accessing }
CTList >> at: index [ 
	"(List withAll: #(1 2 3 4 5)) at: 3"
	self
		foldl: index
		do: [:i :each | 
			i == 1 ifTrue: [^ each].
			i - 1].
	self errorSubscriptBounds: index
]

{ #category : #enumerating }
CTList >> collect: aBlock [
	^ self map: aBlock
]

{ #category : #accessing }
CTList >> contents [
	| index anArray |
	anArray := Array new: self size.
	index := 1.
	self
		do: [ :each | 
			anArray at: index put: each.
			index := index + 1 ].
	^ anArray 
]

{ #category : #enumerating }
CTList >> do: aBlock [ 
	"eveluate a block with each element by eager"
	self
		foldl: nil
		do: [:h :t | aBlock value: t]
]

{ #category : #enumerating }
CTList >> filter: aBlock [ 
	"#(1 2 3 4 5) asPair filter: [ :e | e odd ]"
	^ self
		foldr: self class nil
		do: [:x :xs | (aBlock value: x)
				ifTrue: [self class head: x tail: xs]
				ifFalse: xs]
]

{ #category : #accessing }
CTList >> first [
	^ self head
]

{ #category : #enumerating }
CTList >> foldl: firstValue do: binaryBlock [ 
	"((EagerList withAll: #(2 3 4)) foldl: 1 do: [:h :t | h - t]) = -8"
	"(((1 - 2) - 3) - 4)"

	self isEmpty
		ifTrue: [^ firstValue].
	^ self tail
		foldl: (binaryBlock value: firstValue value: self head)
		do: binaryBlock
]

{ #category : #enumerating }
CTList >> foldr: lastValue do: binaryBlock [ 
	"((EagerList withAll: #(1 2 3)) foldr: 4 do: [:h :t | h - t]) = -2"
	"(1 - (2 - (3 - 4)))"
	self isEmpty ifTrue: [^ lastValue].
	^ binaryBlock
		value: self head
		value: (self tail foldr: lastValue do: binaryBlock)
]

{ #category : #testing }
CTList >> forced [
	"Return true if the value is calculated."
	^ true
]

{ #category : #testing }
CTList >> hash [
	^ self identityHash
]

{ #category : #testing }
CTList >> isEmpty [
	^ self == self class nil
]

{ #category : #testing }
CTList >> isSequenceable [
	^ true
]

{ #category : #enumerating }
CTList >> length [
	"(List withAll: #(1 2 3 4 5)) length"
	^ self
		foldl: 0
		do: [:x :xs | x + 1]
]

{ #category : #debugging }
CTList >> longPrintOn: aStream limitedTo: sizeLimit indent: indent [ 
	aStream nextPutAll: ((self showIndent: indent index: 1) take: sizeLimit)
]

{ #category : #enumerating }
CTList >> map: aBlock [ 
	"(CTLazyList withAll: #(1 2 3 4 5)) map: [ :e | e + 1 ]"
	^ self
		foldr: self class nil
		do: [:x :xs | self class
				head: (aBlock value: x)
				tail: xs]
]

{ #category : #accessing }
CTList >> next [
	^ self tail
]

{ #category : #debugging }
CTList >> printOn: aStream [ 
	aStream nextPutAll: self show

]

{ #category : #debugging }
CTList >> printStringLimitedTo: limit [
	^ (self show take: limit) contentsString

]

{ #category : #enumerating }
CTList >> select: aBlock [
	^ self filter: aBlock 
]

{ #category : #debugging }
CTList >> show [
	"Make a string expression to represent receiver"
	"(EagerList withAll: #(1 2 3)) show contents"
	^ self class name iterator
		, [(self forced
					and: [self isEmpty])
				ifTrue: [' nil' iterator ]
				ifFalse: [self showElement]]
]

{ #category : #debugging }
CTList >> showElement [
	self forced ifFalse: [^ ' ..' iterator].
	self isEmpty ifTrue: [^ CTListIterator nil].

	^ ' ' iterator,
		self head printString iterator,
		[self tail showElement]
]

{ #category : #debugging }
CTList >> showIndent: indent index: index [ 
	"((LazyList withAll: #(1 2 3)) force showIndent: 1 index: 1) contents"
	self forced
		ifFalse: [^ '..' iterator].
	self isEmpty
		ifTrue: [^ CTListIterator nil].
	^ ('	' iterator repeat: indent),
		index printString iterator,
		': 	' iterator,
		self head printString iterator,
		String cr iterator,
		[self tail showIndent: indent index: index + 1]
]

{ #category : #accessing }
CTList >> size [
	^ self length
]

{ #category : #enumerating }
CTList >> sums [
	"LazyList nat sums"
	self isEmpty ifTrue: [^ self class nil].

	^ self class head: self head tail: [self head + self tail sums]
]

{ #category : #enumerating }
CTList >> take: aNumber [ 
	"(EagerList withAll: #(1 2 3 4 5)) take: 3"
	"(EagerList withAll: #(1 2 3 4 5)) take: 10"
	aNumber = 0 ifTrue: [^self class nil].
	self isEmpty ifTrue: [^ self class nil].
	^ self class head: self head tail: (self tail take: aNumber - 1).

]
