instance creation
withAll: aCollection 
	"self withAll: #(1 2 3 4 5)"
	aCollection isEmpty ifTrue: [^ self nil].
	^ self delay: [ {aCollection first . self withAll: aCollection allButFirst} ]
