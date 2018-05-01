enumerating
foldr: lastValue do: binaryBlock 
	"((EagerList withAll: #(1 2 3)) foldr: 4 do: [:h :t | h - t]) = -2"
	"(1 - (2 - (3 - 4)))"
	self isEmpty ifTrue: [^ lastValue].
	^ binaryBlock
		value: self head
		value: (self tail foldr: lastValue do: binaryBlock)