initialization
privateHead: anObject tail: aList
	"Private. Use EagerList class>>head:tail: to make an instance."
	head := anObject.
	tail := aList