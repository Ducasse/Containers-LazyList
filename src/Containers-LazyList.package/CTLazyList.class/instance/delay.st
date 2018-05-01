accessing
delay
	^ delay
		ifNil: [[{head. tail}]]
		ifNotNil: [delay]