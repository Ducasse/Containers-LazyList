enumerating
map: aBlock 
	"(CTLazyList withAll: #(1 2 3 4 5)) map: [ :e | e + 1 ]"
	^ self
		foldr: self class nil
		do: [:x :xs | self class
				head: (aBlock value: x)
				tail: xs]