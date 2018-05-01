examples
fib
	"self fib"
	<sampleInstance>
	| fib |
	fib := 1 followedBy: [1 followedBy: [fib + fib next]].
	^ fib