let rec exist a l = 
	match l with
	| h::t -> if a == h then true else exist a t
	|[] -> false;;

let rec subset a b = 
	match a with
	| h::t -> if exist h b then subset t b else false
	|[] -> true;;

let equal_sets a b = if (subset a b) && (subset b a) then true else false

let rec set_union a b =
	match a with
	| h::t -> if exist h b then set_union t b else set_union t [h]@b
	| [] -> b;;

let rec set_intersection a b =
	match a with
	| h::t -> if exist h b then [h]@(set_intersection t b) else set_intersection t b
	| [] -> [];;

let rec set_diff a b =
	match a with
	| h::t -> if exist h b then set_diff t b else [h]@(set_diff t b)
	| [] -> [];;

let rec computed_fixed_point eq f x = if eq (f x)  x then x else computed_fixed_point eq f (f x);;

let rec computed_p_iteration f p x = 
	match p with
	| 0 -> x
	| 1 -> (f x)
	| _ -> computed_p_iteration f (p - 1) (f x);;

let rec computed_periodic_point eq f p x = 
	if eq (computed_p_iteration f p x) x then x else computed_periodic_point eq f p (f x);;

type ('nonterminal, 'terminal) symbol =
  | N of 'nonterminal
  | T of 'terminal ;;


let rec is_termial_rule rule rules = 
	match rule with 
	| h::t -> 
		(match h with
		| T _-> is_termial_rule t rules
		| _ -> if (List.exists (fun x -> (N (fst x)) = h) rules) then is_termial_rule t rules else false)
	|[] -> true;;


let rec computed_fixed_point eq f x = if eq (f x)  x then x else computed_fixed_point eq f (f x);;

let rec find_non_blind_alley_rule g rules = 
	match (snd g) with
	| [] -> rules
	| h::t -> if is_termial_rule (snd h) rules then find_non_blind_alley_rule ((fst g),t) (set_union [h] rules) else find_non_blind_alley_rule ((fst g),t) rules;;


let rec filter_blind_alleys g = (fst g), set_intersection (snd g) (computed_fixed_point equal_sets (find_non_blind_alley_rule g) []);;



let rec computed_periodic_point eq f p x ->
		match p with
		| 0 -> x
		| _ -> if eq f(computed_periodic_point eq f (p - 1) (f x)) x then x else computed_periodic_point eq f p (fx)




