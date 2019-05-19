Extension { #name : #Object }

{ #category : #'*Containers-LazyList' }
Object >> followedBy: aLazyListOrBlock [
	"Lucid's followed by (fby) operator"
	^ CTLazyList head: self tail: aLazyListOrBlock
]
