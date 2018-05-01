testing
testLazyBasic
	"self debug: #testLazyBasic"
	self assert: (CTLazyList head: 1 tail: CTLazyList nil) contents = #(1).
	self assert: (CTLazyList head: 1 tail: [CTLazyList nil]) contents = #(1).
	self assert: (CTLazyList delay: [{1. CTLazyList nil}]) contents = #(1).

	self assert: (CTLazyList withAll: #()) isEmpty.
	self assert: (CTLazyList withAll: #(1 2 3 4 5)) head = 1.
	self assert: (CTLazyList withAll: #(1 2 3 4 5)) tail length = 4.
	self assert: ((CTLazyList withAll: #(1 2 3 4 5)) tail at: 2) = 3.
	self assert: (CTLazyList withAll: #(1 2 3 4 5)) tail contents = #(2 3 4 5).

	self assert: CTLazyList nat head = 1.
	self assert: (CTLazyList nat tail take: 4) length = 4.
	self assert: (CTLazyList nat tail at: 2) = 3.
	self assert: (CTLazyList nat tail take: 4) contents = #(2 3 4 5).
