testing
testIteratorBasic
	"self debug: #testIteratorBasic"
	self assert: (CTListIterator head: 1 tail: CTListIterator nil) contents = #(1).
	self assert: (CTListIterator head: 1 tail: [CTListIterator nil]) contents = #(1).

	self assert: (CTListIterator withAll: #()) isEmpty.
	self assert: (CTListIterator withAll: #(1 2 3 4 5)) head = 1.
	self assert: (CTListIterator withAll: #(1 2 3 4 5)) tail length = 4.
	self assert: ((CTListIterator withAll: #(1 2 3 4 5)) tail at: 2) = 3.
	self assert: (((CTListIterator withAll: #(1 2)),  (CTListIterator withAll: #(3 4 5))) tail at: 3) = 4.
	self assert: (CTListIterator withAll: #(1 2 3 4 5)) tail contents = #(2 3 4 5).

