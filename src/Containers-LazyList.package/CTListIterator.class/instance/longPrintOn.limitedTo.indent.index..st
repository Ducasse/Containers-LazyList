debugging
longPrintOn: aStream limitedTo: sizeLimit indent: indent index: index 
	| title |
	delay
		ifNotNil: [^ aStream nextPutAll: '...'].
	self isEmpty
		ifTrue: [^ self].
	indent
		timesRepeat: [aStream tab].
	aStream nextPutAll: (title := index printString);
		 nextPut: $:;
		 space;
		 tab.
	aStream
		nextPutAll: (self span
				printStringLimitedTo: (sizeLimit - title size max: 1));
		 cr.
	self successor
		longPrintOn: aStream
		limitedTo: sizeLimit
		indent: indent
		index: index + self span size