accessing
delay
	^ delay
		ifNil: [[{collection. position. successor}]]
		ifNotNil: [delay]