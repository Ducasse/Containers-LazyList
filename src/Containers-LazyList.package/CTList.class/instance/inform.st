enumerating
inform
	self
		do: [:e | (PopUpMenu
					confirm: e printString
					trueChoice: 'next'
					falseChoice: 'cancel')
				ifFalse: [^ self]]