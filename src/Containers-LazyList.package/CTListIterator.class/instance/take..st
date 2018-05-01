enumerating
take: aNumber 
	"((self repeat: 'hello ') take: 100) contents"
	"('hello' iterator take: 3) contents"
	^ self class
		delay: [(aNumber = 0
					or: [self isEmpty])
				ifFalse: [aNumber >= self spanSize
						ifTrue: [{collection. position. self successor take: aNumber - self spanSize}]
						ifFalse: [{collection first: aNumber. 1. self class nil}]]]