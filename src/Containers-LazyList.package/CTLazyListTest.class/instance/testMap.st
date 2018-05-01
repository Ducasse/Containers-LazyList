testing
testMap

	|ll|
	ll := (CTLazyList withAll: #(1 2 3 4 5)) map: [ :e | e + 1 ].
	self assert: ll head equals: 2.
	self assert: ll tail head equals: 3