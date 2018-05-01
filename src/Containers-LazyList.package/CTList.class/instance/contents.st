accessing
contents
	| index anArray |
	anArray := Array new: self size.
	index := 1.
	self
		do: [ :each | 
			anArray at: index put: each.
			index := index + 1 ].
	^ anArray 