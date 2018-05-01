testing
testLazyEnumerating
	"self debug: #testLazyEnumerating"

	self assert: ((CTLazyList nat map: [ :e | e + 1 ]) take: 3) contents = #(2 3 4).
	self assert: ((CTLazyList nat filter: [ :e | e \\ 2 = 0 ]) take: 3) contents = #(2 4 6).
	self assert: ((CTLazyList withAll: #(2 3 4)) foldl: 1 do: [:h :t | h - t]) = -8.
	self assert: ((CTLazyList withAll: #(1 2 3)) foldr: 4 do: [:h :t | h - t]) = -2.

	self assert: (CTLazyList nat take: 5) contents = #(1 2 3 4 5).
	self assert: (((CTLazyList withAll: #(2 1 0)) map: [ :e | 1 / e ]) take: 2) contents =  {1/2. 1}.

	self assert: ((CTLazyList nat + 1) take: 3) contents = #(2 3 4).
	self assert: ((CTLazyList withAll: #(1 2 3)) + (CTLazyList constant: 1)) contents = #(2 3 4).
