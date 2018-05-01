instance creation
head: anObject tail: listOrBlock 
	^ self
		delay: [{{anObject}. 1. listOrBlock value}]