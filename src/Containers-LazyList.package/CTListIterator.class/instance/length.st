accessing
length
	self isEmpty
		ifTrue: [^ 0].
	^ self spanSize + self successor length