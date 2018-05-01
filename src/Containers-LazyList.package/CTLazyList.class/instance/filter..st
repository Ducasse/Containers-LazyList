enumerating
filter: aBlock 
	"(self withAll: #(1 2 3 4 5)) filter: [ :e | e odd ]"
	| each |
	^ self class
		delay: [each := self.
			[each isEmpty
				or: [aBlock value: each head]]
				whileFalse: [each := each tail].
			each isEmpty
				ifFalse: [{each head. each tail filter: aBlock}]]