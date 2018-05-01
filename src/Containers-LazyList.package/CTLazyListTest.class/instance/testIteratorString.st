testing
testIteratorString
	"self debug: #testIteratorString"
	self assert: (CTListIterator withAll: 'Hello') contents = 'Hello'.
	self assert: (CTListIterator head: $H tail: [CTListIterator withAll: 'ello']) contentsString = 'Hello'.
	self assert: (CTListIterator head: $H tail: (CTListIterator withAll: 'ello')) contentsString = 'Hello'.

	self assert: ((CTListIterator withAll: 'He'), [CTListIterator withAll: 'llo']) contents = 'Hello'.
	self assert: ((CTListIterator withAll: 'He'), (CTListIterator withAll: 'llo')) contents = 'Hello'.

	self assert: ((CTListIterator withAll: 'He'),
				(CTListIterator withAll: 'l'),
				(CTListIterator withAll: 'lo')) contents = 'Hello'.
