accessing
force
	| pair |
	delay
		ifNil: [^ nil].
	pair := delay value.
	pair
		ifNil: [head := tail := nil]
		ifNotNil: [head := pair first.
			tail := pair second].
	delay := nil