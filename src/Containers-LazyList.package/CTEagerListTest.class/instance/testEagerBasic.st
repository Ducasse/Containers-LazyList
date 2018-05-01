tests
testEagerBasic
	"self debug: #testEagerBasic"
	self assert: (CTEagerList head: 1 tail: CTEagerList nil) contents equals: #(1).

	self assert: (CTEagerList withAll: #()) length equals: 0.

	self assert: (CTEagerList withAll: #()) isEmpty.
	self assert: (CTEagerList withAll: #(1 2 3 4 5)) head equals: 1.
	self assert: (CTEagerList withAll: #(1 2 3 4 5)) tail length equals: 4.
	self assert: ((CTEagerList withAll: #(1 2 3 4 5)) tail at: 2) equals: 3.
	self assert: (CTEagerList withAll: #(1 2 3 4 5)) tail contents equals: #(2 3 4 5).


	self assert: ((CTEagerList withAll: #(1 2 3)) map: [ :e | e + 1 ]) contents = #(2 3 4).
	self assert: ((CTEagerList withAll: #(2 3 4)) foldl: 1 do: [:h :t | h - t]) = -8.
	self assert: ((CTEagerList withAll: #(1 2 3)) foldr: 4 do: [:h :t | h - t]) = -2
