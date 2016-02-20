type ('nonterminal, 'terminal) symbol =
  | N of 'nonterminal
  | T of 'terminal ;;

(* ************************************************part 1 covert_grammer*************************************************** *)
let rec match_rule rules lrh = 
	match rules with
	| h::t -> if (fst h) == lrh then (snd h)::(match_rule t lrh) else match_rule t lrh
	| _ -> [];;

let rec covert_grammer gram1 = (fst gram1) , match_rule (snd gram1);;




(* *************************************************part 2 matcher********************************************************* *)

(* match symbols in a single rule *)
let rec match_rules start_symbol rules rules_function derivation accept frag = 
	match rules with
	| [] -> None
	| h::t -> match match_single_rule rules_function h accept (derivation@[(start_symbol, h)]) frag with
			  | None -> match_rules start_symbol t rules_function derivation accept frag
		      | result -> result
and match_single_rule rules_function rule accept derivation frag = (* match a symbol to a list of rules *)
	match rule with
	| [] -> accept derivation frag
	| sym::rest_rule -> match sym with
		|(N n_sym) -> match_rules n_sym (rules_function n_sym) rules_function derivation (match_single_rule rules_function rest_rule accept) frag
		|(T t_sym) -> match frag with
							|[] -> None
							|h::t -> if t_sym = h
										 then match_single_rule rules_function rest_rule accept derivation t
										 else None;;					

let parse_prefix gram = fun accept frag ->
	match_rules (fst gram) ((snd gram) (fst gram)) (snd gram) [] accept frag;; 



