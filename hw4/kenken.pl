/*****************************************************************
apply statistics in this way: statistics, kenken(N, C, kenken_testcase),statistics.

@statistics for 6X6 grid test case.
This is the statistics for kenken/3 solving a 6X6 grid can see from the before and after statistics that it took kenken about 0.01 cpu time to solve find a solution. And it took around 500 kb meorry.
            Memory               limit         in use            free

            trail  stack      16383 Kb            0 Kb        16383 Kb
            cstr   stack      16384 Kb            0 Kb        16384 Kb
            global stack      32767 Kb            6 Kb        32761 Kb
            local  stack      16383 Kb            0 Kb        16383 Kb
            atom   table      32768 atoms      1796 atoms     30972 atoms

            Times              since start      since last

            user   time       0.015 sec       0.000 sec
            system time       0.006 sec       0.002 sec
            cpu    time       0.021 sec       0.002 sec
            real   time      23.915 sec      12.510 sec
            Memory               limit         in use            free

            trail  stack      16383 Kb          171 Kb        16212 Kb
            cstr   stack      16383 Kb          120 Kb        16263 Kb
            global stack      32767 Kb          138 Kb        32629 Kb
            local  stack      16383 Kb          273 Kb        16110 Kb
            atom   table      32768 atoms      1796 atoms     30972 atoms

            Times              since start      since last

            user   time       0.027 sec       0.012 sec
            system time       0.006 sec       0.000 sec
            cpu    time       0.033 sec       0.012 sec
            real   time      23.926 sec       0.011 sec

Running the same same statistics check on plain_kenken, it actually couldn't finish in a limited time.(may be cause hours or days to finish, or run out of memeory before find a solution).


@statistics for 4X4 grid test case.
    kenken solve it in 0.001 sec cpu time, use 72kb memeory
    plain_kenken it in 0.04 sec cpu time, however use 45kb memeory

*****************************************************************/

/****************************************************************
kenken implementation with finte domain solve
*****************************************************************/
kenken(N, C, T):-
	length(T, N),
	maplist(set_colum_length(N), T),
	maplist(set_domain(N), T),
	maplist(apply_constrain(T), C),
	maplist(fd_all_different, T),
	length(TT, N),
	maplist(set_colum_length(N), TT),
	maplist(set_domain(N), TT),
	transpose(T, TT, 1-1, N),
	maplist(fd_all_different, TT),
	maplist(fd_labeling, T).

set_colum_length(N, L):- length(L, N).

set_domain(Upper, L):- fd_domain(L, 1, Upper).

%get i-j element from the grid
element(T, I-J, Value):-
	nth(I, T, Row),
	nth(J, Row, Value).

apply_constrain(T, +(S, L)):- add(T, L, S, 0).
apply_constrain(T, *(P, L)):- multiply(T, L, P, 1).
apply_constrain(T, -(D, J, K)) :- subtract(T, D, J, K).
apply_constrain(T, /(Q, J, K)) :- divide(T, Q, J, K).

equal(X, X).

%implement transpose predicate
transpose(T, TT, I-J, N):-
	>(J, N);
	>(I, N);
	element(T, I-J, V1),
	element(TT, J-I, V2),
	equal(V1, V2),
	(II #= I + 1,
	 transpose(T, TT, II-J, N)),
	(JJ #= J + 1,
	 transpose(T, TT, I-JJ, N)).

%implement add predicate
add(_, [], S, S).

add(E, [H|T], S, Result):-
	element(E, H, V),
	New_result #= Result + V,
	add(E, T, S, New_result).


%implement multiply predicate
multiply(_, [], P, P).

multiply(E, [H|T], P, Result):-
	element(E, H, V),
	New_result #= Result * V,
	multiply(E, T, P, New_result).


%implement subtract predicate
subtract(E, D, J, K):- subtraction(E, D, J, K); subtraction(E, D, K, J).
subtraction(E, D, J, K):-
	element(E, J, V1),
	element(E, K, V2),
	V12 #= V1 - V2,
	equal(D, V12).


%implement divde predicate
divide(E, Q, J, K):- division(E, Q, J, K); division(E, Q, K, J).
division(E, Q, J, K):-
	element(E, J, V1),
	element(E, K, V2),
	P #= V2 * Q,
	equal(V1, P).


/****************************************************************
plain_kenken implementation
*****************************************************************/

plain_kenken(N, C, T):-
	length(T, N),
	maplist(set_colum_length(N), T),
	get_domain(N, Domain),
	maplist(permutation(Domain), T),
	maplist(apply_constrain_p(T), C),
	length(TT, N),
	maplist(set_colum_length(N), TT),
	transpose(T, TT, 1-1, N),
	maplist(permutation(Domain), TT).


get_domain(N, Domain):- findall(Num, between(1, N, Num), Domain).

apply_constrain_p(T, +(S, L)):- add_p(T, L, S, 0).
apply_constrain_p(T, *(P, L)):- multiply_p(T, L, P, 1).
apply_constrain_p(T, -(D, J, K)) :- subtract_p(T, D, J, K).
apply_constrain_p(T, /(Q, J, K)) :- divide_p(T, Q, J, K).

%implement add predicate
add_p(_, [], S, S).

add_p(E, [H|T], S, Result):-
	element(E, H, V),
	New_result is Result + V,
	add(E, T, S, New_result).


%implement multiply predicate
multiply_p(_, [], P, P).

multiply_p(E, [H|T], P, Result):-
	element(E, H, V),
	New_result is Result * V,
	multiply(E, T, P, New_result).


%implement subtract predicate
subtract_p(E, D, J, K):- subtraction_p(E, D, J, K); subtraction_p(E, D, K, J).
subtraction_p(E, D, J, K):-
	element(E, J, V1),
	element(E, K, V2),
	V12 is V1 - V2,
	equal(D, V12).


%implement divde predicate
divide_p(E, Q, J, K):- division_p(E, Q, J, K); division_p(E, Q, K, J).
division_p(E, Q, J, K):-
	element(E, J, V1),
	element(E, K, V2),
	P is V2 * Q,
	equal(V1, P).

kenken_testcase(
  6,
  [
   +(11, [1-1, 2-1]),
   /(2, 1-2, 1-3),
   *(20, [1-4, 2-4]),
   *(6, [1-5, 1-6, 2-6, 3-6]),
   -(3, 2-2, 2-3),
   /(3, 2-5, 3-5),
   *(240, [3-1, 3-2, 4-1, 4-2]),
   *(6, [3-3, 3-4]),
   *(6, [4-3, 5-3]),
   +(7, [4-4, 5-4, 5-5]),
   *(30, [4-5, 4-6]),
   *(6, [5-1, 5-2]),
   +(9, [5-6, 6-6]),
   +(8, [6-1, 6-2, 6-3]),
   /(2, 6-4, 6-5)
  ]
).

/*************************************************************************
noop_kenken/4 - API

noop_kenken(Size, Constraints, Op_list, Grid)
@param Size 
 	The size of KenKen matrix and it should be ground terms.
@param Constraints
 	A list of pair contraints put on grid cells to configure the output.
 	And it should a ground term.
 	The constrain pair should follow the following eigther two patterns: 
 	(Target, Jr_Jc, Kr_Kc) or (Target, Cell_list).
 	Constrains that match the first pattern which apply subtraction and division
 	on the paramters to find possible solution. Otherwise, apply addition and 
 	division on the paramters to find possible solution.
@param Op_list
 	A list of operators associated with each constraints.
 	It should be a varible when feed it to noo_kenken, and bind to a list that 
 	only contains +, -, * or /, after return. * @param Solution A solution matrix for the given KenKen constraints

@param Grid
	A varible feed in as a parameter, but bind two a 2-D list with numbers in range 1 to N 
	filled in after return.

Differed from plain_kenken, for each constrain onoop_kenken has two possible branch to continue verus only one branch
in plain_kenken.

Example call:
  noop_kenken(2, 
  	[(1, 1-1, 1-2),
  	 (5, [1-1, 2-1, 2-2)]
    Op_list, T).
 
Result:
  Op_list= [-, +]
  T = [
    [2,1],
    [1,2],
  ];
 
 *************************************************************************/
