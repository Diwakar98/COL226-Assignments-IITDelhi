exception Variable_Not_Initialised;;
exception Error;;
exception TypeError;;
type variable = Var of string;;
type expression = 
		| I of int 
		| B of bool  
		| Var of string 
		| Plus of expression * expression
		| Times of expression * expression
		| Abs of variable * expression 
		| App of expression * expression 
		| If of expression * expression * expression
		| Equal of expression * expression
		| Minus of expression * expression
		| Div of expression * expression
		| Or of expression * expression
		| And of expression * expression
		| Not of expression
		| Greater of expression * expression
		| Lesser of expression * expression
		| NotEqual of expression * expression;;

type opcode = 
		| LDN of int
		| LDB of bool
		| LOOKUP of string
		| PLUS
		| MINUS
		| TIMES
		| DIV
		| CALL
		| RETURN
		| CLOSURE of variable * (opcode list)
		| IF of (opcode list) * (opcode list)
		| EQUAL
		| OR
		| AND
		| NOT
		| GREATER
		| LESSER
		| NOTEQUAL;;


type answer = 
		| Null 
		| Int of int 
		| Bool of bool
		| ValueClosure of environment * variable * (opcode list)
		| List of answer list
	and 
	environment = (variable * answer) list;;

type stack = answer list;;
type control = opcode list;;
type dump = (stack * environment * control) list;;

let rec compile (exp:expression) : control = match exp with
	| I(x) -> [LDN(x)]
	| B(x) -> [LDB(x)]
	| Plus(e1,e2) -> (compile e1) @ (compile e2) @ [PLUS]
	| Minus(e1,e2) -> (compile e1) @ (compile e2) @ [MINUS]
	| Times(e1,e2) -> (compile e1) @ (compile e2) @ [TIMES]
	| Div(e1,e2) -> (compile e1) @ (compile e2) @ [DIV]
	| Var(x) -> [LOOKUP(x)]
	| App(e1,e2) -> (compile e1) @ (compile e2) @ [CALL]
	| Abs(x,e) -> [CLOSURE(x,(compile e)@[RETURN])]
	| If(e1,e2,e3) -> (compile e1) @ [IF(compile e2, compile e3)]
	| Equal(e1,e2) -> (compile e1) @ (compile e2) @ [EQUAL]
	| Or(e1,e2) -> (compile e1) @ (compile e2) @ [OR]
	| And(e1,e2) -> (compile e1) @ (compile e2) @ [AND]
	| Not(e1) -> (compile e1) @ [NOT]
	| Greater(e1,e2) -> (compile e1) @ (compile e2) @ [GREATER]
	| Lesser(e1,e2) -> (compile e1) @ (compile e2) @ [LESSER]
	| NotEqual(e1,e2) -> (compile e1) @ (compile e2) @ [NOTEQUAL]
;;

let rec lookup (env:environment) (x:string) : answer= print_endline "lookup called"; match env with
		| [] -> raise Variable_Not_Initialised
		| (Var(v),ans)::env_rest -> if (x=v) then 
									( 
										match ans with
										| ValueClosure(env1,var1,oplist) -> ValueClosure((Var(v),ans)::env1,var1,oplist)
										| _ -> ans
									)
									else lookup env_rest x;;

let rec secd (stack:stack) (env:environment) (oplist:control) (dump:dump) = match (stack,env,oplist,dump) with
	| (x::[],_,[],_) -> x 
	| (_,_,LDN(x)::oplist_rest,_) -> secd (Int(x)::stack) env oplist_rest dump
	| (_,_,LDB(x)::oplist_rest,_) -> secd (Bool(x)::stack) env oplist_rest dump
	| (_,_,LOOKUP(x)::oplist_rest,_) -> print_endline x; secd ((lookup env x)::stack) env oplist_rest dump
	| (x::ValueClosure(e1,v1,c1)::xs,_,CALL::oplist_rest,_) -> secd [] ((v1,x)::e1) c1 ((xs,env,oplist_rest)::dump)
	| (_,_,CLOSURE(var,oplist)::oplist_rest,_) -> secd (ValueClosure(env,var,oplist)::stack) env oplist_rest dump
	| (x::xs,_,RETURN::oplist_rest,(s1,e1,c1)::drest) -> secd (x::s1) e1 c1 drest
	| (Int(x1)::Int(x2)::xs,_,PLUS::oplist_rest,_) ->  secd (Int(x1+x2)::xs) env oplist_rest dump
	| (Int(x1)::Int(x2)::xs,_,MINUS::oplist_rest,_) ->  secd (Int(x2-x1)::xs) env oplist_rest dump
	| (Int(x1)::Int(x2)::xs,_,TIMES::oplist_rest,_) -> secd (Int(x1*x2)::xs) env oplist_rest dump
	| (Int(x1)::Int(x2)::xs,_,DIV::oplist_rest,_) -> secd (Int(x1/x2)::xs) env oplist_rest dump
	| (Bool(flag)::xs,_,IF(c1,c2)::oplist_rest,_) ->  if flag then secd xs env (c1@oplist_rest) dump  else secd xs env (c2@oplist_rest) dump
	| (x1::x2::xs,_,EQUAL::oplist_rest,_) -> if x1=x2 then secd (Bool(true)::xs) env oplist_rest dump else secd (Bool(false)::xs) env oplist_rest dump
	| (Bool(x1)::Bool(x2)::xs,_,OR::oplist_rest,_) ->  secd (Bool(x1 || x2)::xs) env oplist_rest dump
	| (Bool(x1)::Bool(x2)::xs,_,AND::oplist_rest,_) ->  secd (Bool(x1 && x2)::xs) env oplist_rest dump
	| (Bool(x1)::xs,_,NOT::oplist_rest,_) ->  secd (Bool(not x1)::xs) env oplist_rest dump
	| (x1::x2::xs,_,GREATER::oplist_rest,_) -> if x1<x2 then secd (Bool(true)::xs) env oplist_rest dump else secd (Bool(false)::xs) env oplist_rest dump
	| (x1::x2::xs,_,LESSER::oplist_rest,_) -> if x1>x2 then secd (Bool(true)::xs) env oplist_rest dump else secd (Bool(false)::xs) env oplist_rest dump
	| (x1::x2::xs,_,NOTEQUAL::oplist_rest,_) -> if x1<>x2 then secd (Bool(true)::xs) env oplist_rest dump else secd (Bool(false)::xs) env oplist_rest dump

;;

(* EXPLANATION *)

(*We can easily see that the arguments are being first evaluated the the function is called*)
(*Simple in opcodelist in Application: | App(e1,e2) -> (compile e1) @ (compile e2) @ [CALL] *)
(*So e2 is the argument, it is before the CALL in opcode list. *)
(*It is going to be evaluated first and then passed as argument *)

(* ------------------------------ TESTCASES 0: Simple Expressions ------------------------------ *)

secd [] [] (compile (App(Abs(Var("x"),Plus(I(1),Var("x"))),I(1)))) [];;

secd [] [] (compile (If(Greater(I(4),I(2)),I(3),I(4)))) [];;

secd [] [] (compile (Minus(I(2),I(3)))) [];;



(* ------------------------------ TESTCASES 1: FACTORIAL ------------------------------ *)

(*Expression*)
If(Equal(Var("x"),I(1)), I(1), Times(Var("x"),App(Var("fact"),Plus(Var("x"),I(-1)))))

(*Compiled Expression*)
[LOOKUP "x"; LDN 1; EQUAL;IF ([LDN 1], [LOOKUP "x"; LOOKUP "fact"; LOOKUP "x"; LDN (-1); PLUS; CALL; TIMES])]

(*Adding RETURN to the end of the compiled expression*)
[LOOKUP "x"; LDN 1; EQUAL;IF ([LDN 1], [LOOKUP "x"; LOOKUP "fact"; LOOKUP "x"; LDN (-1); PLUS; CALL; TIMES]); RETURN]

(* Environment *)
[(Var("fact"), ValueClosure([],Var("x"),  [LOOKUP "x"; LDN 1; EQUAL;IF ([LDN 1], [LOOKUP "x"; LOOKUP "fact"; LOOKUP "x"; LDN (-1); PLUS; CALL; TIMES]); RETURN]   ))]


(*Expression for the function call*)
(*Replace 5 below with n to find the factorial of n*)
App(Var("fact"),I(5))

(* Compiled expression for function call *)
(*Replace 5 below with n to find the factorial of n*)
[LOOKUP "fact"; LDN 5; CALL]

(*Replace 5 in control with n to find the factorial of n*)
secd [] [(Var("fact"), ValueClosure([],Var("x"),  [LOOKUP "x"; LDN 1; EQUAL;IF ([LDN 1], [LOOKUP "x"; LOOKUP "fact"; LOOKUP "x"; LDN (-1); PLUS; CALL; TIMES]); RETURN]   ))] [LOOKUP "fact"; LDN 5; CALL] [];;



(* ------------------------------ TESTCASES 2: FIBONACCI ------------------------------ *)

(*Expression*)
If(Equal(Var("x"),I(1)), I(1), Times(Var("x"),App(Var("fact"),Plus(Var("x"),I(-1)))))
If(Equal(Var("x"),I(0)), I(0), If(Equal(Var("x"),I(1)), I(1), Plus( App(Var("fib"),Plus(Var("x"),I(-1)))  , App(Var("fib"),Plus(Var("x"),I(-2)))  ) ))


(*Compiled Expression*)
[LOOKUP "x"; LDN 0; EQUAL; IF ([LDN 0], [LOOKUP "x"; LDN 1; EQUAL; IF ([LDN 1], [LOOKUP "fib"; LOOKUP "x"; LDN (-1); PLUS; CALL; LOOKUP "fib"; LOOKUP "x"; LDN (-2); PLUS; CALL; PLUS])])]

(*Adding RETURN to the end of the compiled expression*)
[LOOKUP "x"; LDN 0; EQUAL; IF ([LDN 0], [LOOKUP "x"; LDN 1; EQUAL; IF ([LDN 1], [LOOKUP "fib"; LOOKUP "x"; LDN (-1); PLUS; CALL; LOOKUP "fib"; LOOKUP "x"; LDN (-2); PLUS; CALL; PLUS])]); RETURN]

(* Environment *)
[(Var("fib"), ValueClosure([],Var("x"),  [LOOKUP "x"; LDN 0; EQUAL; IF ([LDN 0], [LOOKUP "x"; LDN 1; EQUAL; IF ([LDN 1], [LOOKUP "fib"; LOOKUP "x"; LDN (-1); PLUS; CALL; LOOKUP "fib"; LOOKUP "x"; LDN (-2); PLUS; CALL; PLUS])]); RETURN]   ))]


(*Expression for the function call*)
(*Replace 6 below with n to find nth fibonacci number of *)
(* 0 1 1 2 3 5 8 13 21 . . . *)
App(Var("fib"),I(6))

(* Compiled expression for function call *)
(*Replace 6 below with n to find nth fibonacci number of *)
[LOOKUP "fib"; LDN 6; CALL]

(*Replace 6 in control with n to find nth fibonacci number*)
secd [] [(Var("fib"), ValueClosure([],Var("x"),  [LOOKUP "x"; LDN 0; EQUAL; IF ([LDN 0], [LOOKUP "x"; LDN 1; EQUAL; IF ([LDN 1], [LOOKUP "fib"; LOOKUP "x"; LDN (-1); PLUS; CALL; LOOKUP "fib"; LOOKUP "x"; LDN (-2); PLUS; CALL; PLUS])]); RETURN]   ))] [LOOKUP "fib"; LDN 6; CALL] [];;








