debugging
showIndent: indent index: index 
	"((LazyList withAll: #(1 2 3)) force showIndent: 1 index: 1) contents"
	self forced
		ifFalse: [^ '..' iterator].
	self isEmpty
		ifTrue: [^ CTListIterator nil].
	^ ('	' iterator repeat: indent),
		index printString iterator,
		': 	' iterator,
		self head printString iterator,
		String cr iterator,
		[self tail showIndent: indent index: index + 1]