accessing
contentsString
	| aString index |
	aString := String new: self size.
	index := 1.
	self
		do: [:each | 
			aString at: index put: each.
			index := index + 1].
	^ aString