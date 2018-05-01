instance creation
withAll: aCollection 
	"BUG: a nil iterator losts the collection flavor (Array, String, etc...)"
	aCollection isEmpty
		ifTrue: [^ self nil].
	^ self
		collection: aCollection
		position: 1
		successor: self nil