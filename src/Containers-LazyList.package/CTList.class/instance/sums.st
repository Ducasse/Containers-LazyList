enumerating
sums
	"LazyList nat sums"
	self isEmpty ifTrue: [^ self class nil].

	^ self class head: self head tail: [self head + self tail sums]