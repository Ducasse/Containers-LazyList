examples
helloForever
	<sampleInstance>
	"(self helloForever take: 50) contentsString"
	^ (self withAll: 'Hello ')
		, [(self withAll: 'World! ')
				, [self helloForever]]