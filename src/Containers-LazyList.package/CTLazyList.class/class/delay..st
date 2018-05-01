instance creation
delay: aBlock
	"aBlock is a block which answers {anObject. aLazyList}"
	^ self new privateDelay: aBlock