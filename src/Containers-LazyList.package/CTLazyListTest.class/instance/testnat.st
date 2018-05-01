testing
testnat

	| ll |
	ll := (CTLazyList nat map: [:e | e odd]).
	self assert: ll head equals: true.
	self assert: ll tail head equals: false.
	self assert: ll tail tail head equals: true.