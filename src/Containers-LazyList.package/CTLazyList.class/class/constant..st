scripts
constant: x
	"Return an infinite list of x"

	^ self
		delay: [ {x.
			(self constant: x)} ]