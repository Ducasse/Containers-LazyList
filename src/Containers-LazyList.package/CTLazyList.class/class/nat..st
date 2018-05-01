scripts
nat: n
	"self nat: 1"
	^ self
		delay: [{n. self nat: n + 1}]