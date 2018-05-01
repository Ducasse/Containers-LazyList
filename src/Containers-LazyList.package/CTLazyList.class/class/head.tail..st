instance creation
head: anObject tail: listOrBlock 
	^ self
		delay: [{anObject. listOrBlock value}]