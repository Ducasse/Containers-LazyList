debugging
show
	"Make a string expression to represent receiver"
	"(EagerList withAll: #(1 2 3)) show contents"
	^ self class name iterator
		, [(self forced
					and: [self isEmpty])
				ifTrue: [' nil' iterator ]
				ifFalse: [self showElement]]