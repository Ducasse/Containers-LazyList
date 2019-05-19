Class {
	#name : #BaselineOfContainersLazyList,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersLazyList
}

{ #category : #baselines }
BaselineOfContainersLazyList >> baseline: spec [
	<baseline>

	spec for: #pharo do: [		
		spec package: 'Containers-LazyList'.
	]
]
