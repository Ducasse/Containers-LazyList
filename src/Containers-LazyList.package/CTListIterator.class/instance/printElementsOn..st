debugging
printElementsOn: aStream 
	delay
		ifNotNil: [^ aStream nextPutAll: '...'].
	self isEmpty
		ifTrue: [^ self].
	self span printOn: aStream.
	self successor printElementsOn: aStream