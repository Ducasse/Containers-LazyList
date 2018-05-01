enumerating
with: otherCollection collect: twoArgBlock 
	"zipWith function"
	"(self constant: 3) + (self constant: 4)"
	^ self class
		delay: [(self isEmpty
					or: [otherCollection isEmpty])
				ifFalse: [{twoArgBlock value: self head value: otherCollection head. self tail with: otherCollection tail collect: twoArgBlock}]]