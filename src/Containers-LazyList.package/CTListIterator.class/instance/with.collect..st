enumerating
with: otherCollection collect: twoArgBlock 
	"zipWith function.
	BUG: it assumes receiver and otherCollection is same size."
	"(self repeat: #(1 2 3)) + (self repeat: #(1 1))"
	"(self repeat: #(1 2 3)) + ((self repeat: #(1 1)) take: 10)"
	| newCollection other |
	self isEmpty
		ifTrue: [^ self].
	otherCollection isEmpty
		ifTrue: [^ self].
	other := otherCollection.
	^ self class
		delay: [newCollection := collection species new: self spanSize.
			position
				to: collection size
				do: [:i | 
					newCollection
						at: i - position + 1
						put: (twoArgBlock
								value: (collection at: i)
								value: other head).
					other := other tail].
			{newCollection. 1. successor with: other collect: twoArgBlock}]