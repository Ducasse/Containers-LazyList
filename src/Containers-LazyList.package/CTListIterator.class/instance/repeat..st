accessing
repeat: aNumber 
	"'yey ' iterator repeat: 10"
	^ aNumber = 0
		ifTrue: [self class nil]
		ifFalse: [self
				, [self repeat: aNumber - 1]]