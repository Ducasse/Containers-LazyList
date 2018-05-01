accessing
force
	| triplet |
	delay
		ifNil: [^ nil].
	triplet := delay value.
	triplet
		ifNil: [self
				privateCollection: nil
				position: nil
				successor: nil]
		ifNotNil: [self
				privateCollection: triplet first
				position: triplet second
				successor: triplet third].
	delay := nil