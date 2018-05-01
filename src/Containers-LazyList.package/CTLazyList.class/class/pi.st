examples
pi
	<sampleInstance>
	"Structure and Interpretation of Computer Programs 3.5.3.
	PI = 4 * (1 - (1/3) + (1/5) - (1/7) + ..."
	"self pi explore"

	| flipFunc flip oddNums summands pi |

	flipFunc := [:n | n followedBy: [(flipFunc value: n) negated]].
	flip := flipFunc value: 1.

	oddNums := 1 followedBy: [oddNums + 2].

	summands := 1 / oddNums * flip.

	pi := summands sums * 4.0.
	^ pi
