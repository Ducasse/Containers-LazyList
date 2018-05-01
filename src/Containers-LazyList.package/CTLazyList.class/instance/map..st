enumerating
map: aBlock 
	"self nat map: [ :e | e + 1 ]"
	^ self class
		delay: [self isEmpty
				ifFalse: [{aBlock value: self head. self tail map: aBlock}]]