scripts
sieve: list 
	"self sieve: (self nat: 2)"
	Transcript cr; show: (list take: 10) contents.


	^ list first followedBy: [
			self sieve:
				(list next filter: [:e | e \\ list first ~= 0])]