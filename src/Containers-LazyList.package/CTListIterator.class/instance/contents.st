accessing
contents
	| newCollection index each |
	newCollection := self collection species new: self length.
	index := 1.
	each := self.
	[each isEmpty]
		whileFalse: [newCollection
				replaceFrom: index
				to: index + each spanSize - 1
				with: each collection
				startingAt: each position.
			index := index + each collection size.
			each := each successor].
	^ newCollection