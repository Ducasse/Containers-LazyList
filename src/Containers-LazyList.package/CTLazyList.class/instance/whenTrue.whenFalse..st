enumerating
whenTrue: list2 whenFalse: list3 
	"Listwize condition. Note: list2 and list3 are lists, not blocks."
	"(self nat map: [:e | e odd]) whenTrue: (self constant: 1) whenFalse: (self constant: 0)"
	^ self class
		delay: [(self isEmpty
					or: [list2 isEmpty
							or: [list3 isEmpty]])
				ifFalse: [
					{self head
						ifTrue: [list2 head]
						ifFalse: [list3 head].
					self tail
						whenTrue: list2 tail
						whenFalse: list3 tail}]]