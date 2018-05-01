enumerating
foldl: firstValue do: binaryBlock 
	"((EagerList withAll: #(2 3 4)) foldl: 1 do: [:h :t | h - t]) = -8"
	"(((1 - 2) - 3) - 4)"

	self isEmpty
		ifTrue: [^ firstValue].
	^ self tail
		foldl: (binaryBlock value: firstValue value: self head)
		do: binaryBlock