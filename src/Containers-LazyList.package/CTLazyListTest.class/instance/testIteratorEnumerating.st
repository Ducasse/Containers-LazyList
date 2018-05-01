testing
testIteratorEnumerating
	"self debug: #testIteratorEnumerating"

	self assert: ((CTListIterator withAll: #(1 2 3)) map: [ :e | e + 1 ]) contents = #(2 3 4).
	self assert: (((CTListIterator repeat: #(1 2 3)) filter: [ :e | e \\ 2 = 1 ]) take: 3) contents = #(1 3 1).

	self assert: ((CTListIterator withAll: #(2 3 4)) foldl: 1 do: [:h :t | h - t]) = -8.
	self assert: ((CTListIterator withAll: #(1 2 3)) foldr: 4 do: [:h :t | h - t]) = -2.

	self assert: ((CTListIterator nat: 1) take: 5) contents = #(1 2 3 4 5).
	self assert: ((((CTListIterator withAll: #(2 1)), (CTListIterator withAll: #(0))) map: [ :e | 1 / e ]) take: 2) contents =  {1/2. 1}.

	self assert: (((CTListIterator nat: 1) map: [ :e | e + 1 ]) take: 5) contents = #(2 3 4 5 6).
	self assert: (((CTListIterator nat: 1) filter: [ :e | e odd ]) take: 5) contents = #(1 3 5 7 9).
	self assert: ((CTListIterator withAll: #(1 2 3)) + 1) contents = #(2 3 4).
	self assert: ((CTListIterator withAll: #(1 2 3)) + (CTListIterator repeat: #(1))) contents = #(2 3 4).
