enumerating
, ys 
	^ self
		foldr: ys
		do: [:x :xs | self class head: x tail: xs]