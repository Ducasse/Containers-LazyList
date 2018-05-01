enumerating
length
	"(List withAll: #(1 2 3 4 5)) length"
	^ self
		foldl: 0
		do: [:x :xs | x + 1]