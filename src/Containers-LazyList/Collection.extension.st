Extension { #name : #Collection }

{ #category : #'*Containers-LazyList' }
Collection >> iterator [
	^ CTListIterator withAll: self
]
