testing
testwhenTruewhenFalse
	| ll |
	ll := (CTLazyList nat map: [:e | e odd]) 
				whenTrue: (CTLazyList constant: 1) 
				whenFalse: (CTLazyList constant: 0).
	
	self assert: ll head equals: 1.
	self assert: ll tail head equals: 0.
	self assert: ll tail tail head equals: 1.
	