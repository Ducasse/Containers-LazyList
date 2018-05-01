instance creation
delay: aBlock
	"The primary constructor of Iterator.
	aBlock answers a triplet {aCollection. index. anIterator} or nil."
	^ self new privateDelay: aBlock