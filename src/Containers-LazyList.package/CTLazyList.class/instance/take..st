enumerating
take: n 
	n = 0
		ifTrue: [^ self class nil].
	^ self class
		delay: [{self head. (self tail take: n - 1)}]