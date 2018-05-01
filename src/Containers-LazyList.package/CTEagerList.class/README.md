I am a simple lisp style eager list made of cons cell.
I exist as a reference implementation of list protocol.

EagerList nil "singleton sentinel"

Structure:
 head		Object -- current object (CAR).
 tail		EagerList -- next list (CDR).
