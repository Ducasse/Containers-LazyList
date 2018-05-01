scripts
position: position velocity: velocity acceleration: acceleration 
	"self position: 0 velocity: 1 acceleration: 1"
	^ position
		followedBy: [self
				position: position + velocity
				velocity: velocity + acceleration
				acceleration: acceleration]