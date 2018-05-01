testing
testFollowed
	"self run: #testFollowed"
	| ll |
	ll := 1 followedBy: (2 followedBy: (3 followedBy: CTLazyList nil)).
	self assert: ll class = CTLazyList