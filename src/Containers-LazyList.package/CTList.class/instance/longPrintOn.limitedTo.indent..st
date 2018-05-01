debugging
longPrintOn: aStream limitedTo: sizeLimit indent: indent 
	aStream nextPutAll: ((self showIndent: indent index: 1) take: sizeLimit)