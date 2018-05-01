scripts
fib: a with: b 
	"self fib: 1 with: 1"
	^ self
		delay: [{a.  self fib: b with: a + b}]