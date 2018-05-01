examples
nat: a 
	"(self nat: 1) take: 5"
	^ self delay: [{{a}. 1. self nat: a + 1}]