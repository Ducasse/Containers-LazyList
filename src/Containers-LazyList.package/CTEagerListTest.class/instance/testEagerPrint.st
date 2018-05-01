tests
testEagerPrint
	"self debug: #testEagerPrint"
	self assert: (CTEagerList withAll: #()) printString equals: 'CTEagerList nil'.
	self assert: (CTEagerList withAll: #(1)) printString equals: 'CTEagerList 1'.
	self assert: (CTEagerList withAll: #(1 2)) printString equals: 'CTEagerList 1 2'.
	self assert: (CTEagerList withAll: #(1 2 3)) printString equals: 'CTEagerList 1 2 3'.
