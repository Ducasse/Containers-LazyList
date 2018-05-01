testing
testEmpty

	self assert: (CTLazyList new isEmpty).
	self assert: (CTLazyList withAll: #()) isEmpty.
	self deny: (CTLazyList withAll: #(1 2)) isEmpty