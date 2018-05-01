examples
nat
	"CTLazyList nat"
	"CTListIterator nat"

	| nat |
	nat := self head: 1 tail: [ nat + 1 ].
	^ nat