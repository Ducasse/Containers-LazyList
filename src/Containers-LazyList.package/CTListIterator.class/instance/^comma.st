enumerating
, iteratorOrBlock 
	"Append two iterators"
	"(Iterator withAll: 'He'), [Iterator withAll: 'llo']"
	^ self class
		delay: [self isEmpty
				ifTrue: [iteratorOrBlock value delay value]
				ifFalse: [{self collection. self position. self successor, iteratorOrBlock value}]]