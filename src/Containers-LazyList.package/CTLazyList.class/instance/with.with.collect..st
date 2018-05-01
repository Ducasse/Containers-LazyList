enumerating
with: list2 with: list3 collect: threeArgBlock 
	"zipWith3 function"
	"(self constant: 3) + (self constant: 4)"
	^ self class
		delay: [(self isEmpty
					or: [list2 isEmpty
							or: [list3 isEmpty]])
				ifFalse: [
					{threeArgBlock
						value: self head
						value: list2 head
						value: list3 head.
					self tail
						with: list2 tail
						with: list3 tail
						collect: threeArgBlock}]]