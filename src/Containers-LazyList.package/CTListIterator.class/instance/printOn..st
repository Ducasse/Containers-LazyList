debugging
printOn: aStream 
	"Append a sequence of characters that identify the receiver to aStream."

	self printNameOn: aStream.
	aStream space.
	self printElementsOn: aStream