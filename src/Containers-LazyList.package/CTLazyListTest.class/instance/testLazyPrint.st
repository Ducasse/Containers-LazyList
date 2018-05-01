testing
testLazyPrint
	"self debug: #testLazyPrint"
	self assert: (CTLazyList withAll: #()) show contents equals: 'CTLazyList nil'.
	self assert: (CTLazyList delay: []) show contents equals: 'CTLazyList ..'.
	self assert: (CTLazyList withAll: #(1)) force show contents equals: 'CTLazyList 1'.
	self assert: (CTLazyList withAll: #(1 2)) force show contents equals: 'CTLazyList 1 ..'.
	self assert: (CTLazyList withAll: #(1 2 3)) force show contents equals: 'CTLazyList 1 ..'.
