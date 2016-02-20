let accept_all derivation string = Some (derivation, string);;
let accept_empty_suffix derivation = function
   | [] -> Some (derivation, [])
   | _ -> None;;

type english_nonterminal =
	|Sentence |Noun |Verb |Preposition |Conj |Adj |Adv |Pronoun| VP | NP  ;;

let english_grammer = 
	(Sentence,
		function
			| Sentence ->
				[[N NP; N VP; N NP];
				 [N NP; N VP; N NP; N Adv;];
				 [N NP; N Verb; N Adj];
				 [N NP; N Verb];
				 [N NP; N VP; N Conj; N Sentence]]
			| NP ->
				[[N Noun];
				 [N Adj; N Noun];
				 [N Pronoun]]
			| VP ->
				[[N Verb];
				 [N Verb; N Preposition];
				 [N Adv; N Verb]] 
			| Noun ->
				[[T"CS131"];[T"CS111"];[T"hardwork"];[T"homework2"]]
			| Verb ->
				[[T"like"]; [T"think"]; [T"is"]; [T"are"]; [T"do"]; [T"does"]; [T"requires"];[T"beats"]]
			| Adv ->
				[[T"really"]]
			| Adj ->
				[[T"hard"]; [T"tremendous"]]
			| Pronoun ->
				[[T"this"];[T"it"];[T"she"]; [T"I"]]
			| Preposition ->
				[[T"in"];[T"for"];[T"at"]]
			| Conj ->
				[[T"that"]; [T"which"]]);;

let test_1 = 
  	((parse_prefix english_grammer accept_empty_suffix ["CS131"; "requires"; "tremendous"; "hardwork"])
   		= Some
		 ([(Sentence, [N NP; N VP; N NP]); (NP, [N Noun]); (Noun, [T "CS131"]);
  			(VP, [N Verb]); 
  			(Verb, [T "requires"]); 
  			(NP, [N Adj; N Noun]);
   			(Adj, [T "tremendous"]);
   			 (Noun, [T "hardwork"])],
 		 []));;
 
 let test_2 = 
 	((parse_prefix english_grammer accept_empty_suffix ["I"; "think"; "that"; "homework2"; "is" ;"hard"])
   		= Some ([(Sentence, [N NP; N VP; N Conj; N Sentence]); 
   					(NP, [N Pronoun]);
   					(Pronoun, [T "I"]); 
   					(VP, [N Verb]); 
   					(Verb, [T "think"]);
   					(Conj, [T "that"]); 
   					(Sentence, [N NP; N Verb; N Adj]); 
   					(NP, [N Noun]);
   					(Noun, [T "homework2"]); 
   					(Verb, [T "is"]); 
   					(Adj, [T "hard"])],
  				[]));;



















