debugging
explorerContents
	self isEmpty ifTrue: [ ^#() ].
	^ {ObjectExplorerWrapper
			with: self head
			name: 'head'
			model: self.
		ObjectExplorerWrapper
			with: self tail
			name: 'tail'
			model: self}