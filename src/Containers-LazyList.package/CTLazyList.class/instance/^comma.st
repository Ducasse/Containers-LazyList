enumerating
, listOrBlock 
	"(LazyList withAll: 'He'), [LazyList withAll: 'llo']"
	^ self class
		delay: [self isEmpty
				ifTrue: [listOrBlock value delay value]
				ifFalse: [{self head. self tail , listOrBlock}]]