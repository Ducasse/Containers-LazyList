debugging
showElement
	self forced ifFalse: [^ ' ..' iterator].
	self isEmpty ifTrue: [^ CTListIterator nil].

	^ ' ' iterator,
		self head printString iterator,
		[self tail showElement]