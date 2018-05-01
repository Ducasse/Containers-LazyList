debugging
explorerContents
	self isEmpty ifTrue: [ ^#() ].
	^ {ObjectExplorerWrapper
			with: self span
			name: 'span'
			model: self.
		ObjectExplorerWrapper
			with: self successor
			name: 'successor'
			model: self}