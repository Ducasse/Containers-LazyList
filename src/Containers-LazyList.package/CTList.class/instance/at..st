accessing
at: index 
	"(List withAll: #(1 2 3 4 5)) at: 3"
	self
		foldl: index
		do: [:i :each | 
			i == 1 ifTrue: [^ each].
			i - 1].
	self errorSubscriptBounds: index