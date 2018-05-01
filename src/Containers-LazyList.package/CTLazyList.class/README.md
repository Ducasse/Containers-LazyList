I am a lazy list (stream) implementation based on the idea of
SRFI-40 (http://srfi.schemers.org/srfi-40/srfi-40.html).
My element is calculated only when it is necessary, so you can
construct and composite inifinite lists.

I have been originally implemented by Takashi Yamamiya.

LazyList nil "a sentinel (not singleton)"


A lazy list is a collection where each element is evaluated only when it's necessary. Lazy lists are very useful to express mathematical infinite sequence naturally like all natural numbers, entire prime numbers, or so.
Lazy lists are also practical when you deal with a large sequence of data. Imagine that you want to replace particular words in a large text, and print out just the first 100 characters. Without lazy list, you must either, 1) replace all words and take first 100 characters, or 2) count character position carefully each time when a word is replaced. 1) requires time, and 2) tend to lost modularity. With lazy lists, you can write such program as simple as former way, but performance is still reasonable.



Implementation 

Structure:
 head			Object -- current object
 tail			LazyList -- a pointer for next list
 delay		Block -- a promise which returns a pair of {head. tail}


