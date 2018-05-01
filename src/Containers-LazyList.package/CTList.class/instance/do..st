enumerating
do: aBlock 
	"eveluate a block with each element by eager"
	self
		foldl: nil
		do: [:h :t | aBlock value: t]