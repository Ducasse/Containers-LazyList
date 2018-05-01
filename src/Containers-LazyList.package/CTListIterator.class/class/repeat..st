instance creation
repeat: aCollection
	"(self repeat: #(6)) * 7"
	"6 * (self repeat: #(7))"
	^ self
		delay: [{aCollection. 1. self repeat: aCollection}]