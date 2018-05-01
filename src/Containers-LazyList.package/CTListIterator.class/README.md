I am an optimised lazy list for long collection like Stream.

Iterator nil "a sentinel (not singleton)"

Structure:
 collection			Collection -- current collection
 position			Integer -- current position
 successor			Iterator -- a pointer for next Iterator
 delay				Block -- promis which returns a triplet of {collection, position, successor}