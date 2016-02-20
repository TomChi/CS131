fun x -> x + 1 // supoort currying

lef f = fun x y -> x + y
	fun x -> fun y -> x + y    // are these two the same( are all more than one argument fun define function are currying internal)
 



function x  -> x + 1 // suport partern matching. built-in  match 

function 
	| [] -> 12
	| [] -> 13
	| _ -> 0

type mytype =
	| Foo
	| Bar of int
	| Baz of string * int

type 'a option = 
	| Some of 'a
	| None

match v with
	| Some x -> print x
	| None

type 'a llist = 
	| Empty
	| Cons of 'a *'a llist;;

let rec len = 
	function
		|Empty -> []
		|Cons(_, t) -> 1 + len t


let f x'a = x // type cast

f v 


Reasons to prefer one syntax to antoher

* close to natural language  (Cobal)
* concise    (APL)
	writable
	readable
* similar to common practice (e.g match, familiar programming language)
* simple rule for syntax( spec/ grammer is small - easy to write - easy to implement)
* encourage library
* unambiguous
* reddundant(provide more syntax than needs)


Syntax from bottom up

Lowest level: byte
Next level: characters
Next level: tokens 
  types of tokens:
  	not tokens: comment, 'white space'
  x = *p ------q; (*p-- - --q); what tokenization do is *p-- -- - q // error
  multiple char ops 
  	-> **

tokenize if greedy
	 keywords but not reserved:
	 PLI 
	 if (a == b) than if  = if  + 1 else x = y + 3


	Numbers

	x = - 217473487  -2**31

	if (-217373487 < 0) // 2**31 is too big as int, it tookinzed as an unsgined int, negate on unsigned int is still int)
		print(true)

	solution 
	#include< limits.h>  where #define INT_MIN (-1 - 2174.....)

	  if(a) = b;  if(if(a) -b) than 

Formal Language:
	token = predefined finite set
	sentence = finite sequnce of tokens
	language = set of sentences



