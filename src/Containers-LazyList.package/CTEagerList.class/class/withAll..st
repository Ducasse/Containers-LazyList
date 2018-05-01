instance creation
withAll: aCollection 
	"self withAll: #(1 2 3 4 5)"
	^ aCollection reverse
		inject: self nil
		into: [:tail :head | self head: head tail: tail]