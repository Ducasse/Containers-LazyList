enumerating
filter: aBlock 
	"#(1 2 3 4 5) asPair filter: [ :e | e odd ]"
	^ self
		foldr: self class nil
		do: [:x :xs | (aBlock value: x)
				ifTrue: [self class head: x tail: xs]
				ifFalse: xs]