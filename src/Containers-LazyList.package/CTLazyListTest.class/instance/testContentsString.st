testing
testContentsString
	"self debug: #testString"
	self assert: (CTLazyList withAll: 'Hello') contentsString = 'Hello'.
	self assert: (CTLazyList head: $H tail: [CTLazyList withAll: 'ello']) contentsString = 'Hello'.
	self assert: (CTLazyList head: $H tail: (CTLazyList withAll: 'ello')) contentsString = 'Hello'.

	self assert: ((CTLazyList withAll: 'He'), [CTLazyList withAll: 'llo']) contentsString = 'Hello'.
	self assert: ((CTLazyList withAll: 'He'), (CTLazyList withAll: 'llo')) contentsString = 'Hello'.
