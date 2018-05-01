enumerating
take: aNumber 
	"(EagerList withAll: #(1 2 3 4 5)) take: 3"
	"(EagerList withAll: #(1 2 3 4 5)) take: 10"
	aNumber = 0 ifTrue: [^self class nil].
	self isEmpty ifTrue: [^ self class nil].
	^ self class head: self head tail: (self tail take: aNumber - 1).
