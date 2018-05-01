enumerating
filter: aBlock 
	"(self repeat: #(1 2 3 4 5)) filter: [ :e | e odd ]"
	| buffer j newCollection |
	^ self class
		delay: [self isEmpty
				ifTrue: [nil]
				ifFalse: [buffer := self collection species new: self spanSize.
					j := 1.
					self position
						to: self collection size
						do: [:i | (aBlock
									value: (self collection at: i))
								ifTrue: [buffer
										at: j
										put: (self collection at: i).
									j := j + 1]].
					newCollection := buffer copyFrom: 1 to: j - 1.
					newCollection isEmpty
						ifTrue: [(self successor filter: aBlock) delay value]
						ifFalse: [{newCollection. 1. self successor filter: aBlock}]]]