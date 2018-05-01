accessing
tail
	^ self position = self collection size
		ifTrue: [self successor]
		ifFalse: [self class
				collection: self collection
				position: self position + 1
				successor: self successor]