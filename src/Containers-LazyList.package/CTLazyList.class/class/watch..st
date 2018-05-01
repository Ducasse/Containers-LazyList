scripts
watch: aBlock
	"self watch: [Time now]"
	^ self delay: [{aBlock value. self watch: aBlock}]