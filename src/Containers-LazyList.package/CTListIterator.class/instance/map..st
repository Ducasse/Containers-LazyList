enumerating
map: aBlock 
	"(self repeat: #(1 2 3 4 5)) tail map: [ :e | e + 1 ]"
	| newCollection |
	^ self class
		delay: [self isEmpty
				ifTrue: [nil]
				ifFalse: [newCollection := self collection species new: self spanSize.
					self position
						to: self collection size
						do: [:i | newCollection
								at: i - self position + 1
								put: (aBlock
										value: (self collection at: i))].
					{newCollection. 1. self successor map: aBlock}]]