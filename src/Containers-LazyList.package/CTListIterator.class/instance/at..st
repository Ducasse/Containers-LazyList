accessing
at: index 
	^ index > self spanSize
		ifTrue: [self successor at: index - self spanSize]
		ifFalse: [self collection at: self position + index - 1]