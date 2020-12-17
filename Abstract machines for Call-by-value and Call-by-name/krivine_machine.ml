exception Variable_Not_Initialised;;
exception Error;;
exception TypeError;;
type var = string;;
type variable = Var of string;;
type answer = 
		| Null 
		| Unit 
		| Int of int 
		| Bool of bool;;
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

type ans = 
	| Ans_int of int 
	| Ans_bool of bool;;

type environment = (variable * closure) list
		and
	closure = Closure of (environment * expression);;

let rec lookup (env:environment) (x:string) :closure= match env with
		| [] -> raise Variable_Not_Initialised
		| (Var(v),closure)::env_rest -> if (x=v) then 
										(
											match closure with
											| Closure(env1,Abs(x1,x2)) -> Closure((Var(v),closure)::env1,Abs(x1,x2))
											| _ -> closure
										)
										else lookup env_rest x;;

let times_helper c1 c2 = match (c1,c2) with
		| (Closure(env1,I(x1)),Closure(env2,I(x2))) -> Closure([],I(x1*x2));;
let plus_helper c1 c2 = match (c1,c2) with
		| (Closure(env1,I(x1)),Closure(env2,I(x2))) -> Closure([],I(x1+x2));;
let div_helper c1 c2 = match (c1,c2) with
		| (Closure(env1,I(x1)),Closure(env2,I(x2))) -> Closure([],I(x1/x2));;
let minus_helper c1 c2 = match (c1,c2) with
		| (Closure(env1,I(x1)),Closure(env2,I(x2))) -> Closure([],I(x1-x2));;

let or_helper c1 c2 = match (c1,c2) with
		| (Closure(env1,B(x1)),Closure(env2,B(x2))) -> Closure([],B(x1 || x2));;
let and_helper c1 c2 = match (c1,c2) with
		| (Closure(env1,B(x1)),Closure(env2,B(x2))) -> Closure([],B(x1 && x2));;
let not_helper c = match (c) with
		| Closure(env1,B(x)) -> Closure([],B(not x));;


let rec eval (clos:closure) stack = match (clos,stack) with
		| (Closure(env,I(x)),_) -> Closure(env,I(x))
		| (Closure(env,B(x)),_) -> Closure(env,B(x))
		| (Closure(env,Var(x)),s) -> eval (lookup env x) s
		| (Closure(env,Abs(x,e)),[]) -> Closure(env,Abs(x,e))
		| (Closure(env,Abs(x,e)),d::ds) -> eval (Closure((x,d)::env,e)) ds
		| (Closure(env,App(e1,e2)),s) ->  eval (Closure(env,e1)) (Closure(env,e2)::s)
		| (Closure(env,Times(e1,e2)),s) -> let t1 = eval (Closure(env,e1)) [] in let t2 = eval (Closure(env,e2)) [] in
											eval (times_helper t1 t2) s

		| (Closure(env,Plus(e1,e2)),s) -> let t1 = eval (Closure(env,e1)) [] in let t2 = eval (Closure(env,e2)) [] in 
											eval (plus_helper t1 t2) s

		| (Closure(env,Minus(e1,e2)),s) -> let t1 = eval (Closure(env,e1)) [] in let t2 = eval (Closure(env,e2)) [] in 
											eval (minus_helper t1 t2) s

		| (Closure(env,Div(e1,e2)),s) -> let t1 = eval (Closure(env,e1)) [] in let t2 = eval (Closure(env,e2)) [] in 
											eval (div_helper t1 t2) s

		| (Closure(env,Or(e1,e2)),s) -> let t1 = eval (Closure(env,e1)) [] in let t2 = eval (Closure(env,e2)) [] in 
											eval (or_helper t1 t2) s
		| (Closure(env,And(e1,e2)),s) -> let t1 = eval (Closure(env,e1)) [] in let t2 = eval (Closure(env,e2)) [] in 
											eval (and_helper t1 t2) s
		| (Closure(env,Not(e)),s) -> let t = eval (Closure(env,e)) [] in
											eval (not_helper t) s


		| (Closure(env,If(e1,e2,e3)),s) ->	begin 
										let t1 = eval (Closure(env,e1)) [] in
											match t1 with
											| Closure(env1,B(flag)) -> if flag then eval (Closure(env,e2)) s else eval (Closure(env,e3)) s
											| _ -> raise TypeError
										end

		| (Closure(env,Equal(e1,e2)),s) -> begin 
										let t1 = (eval (Closure(env,e1)) []) in let t2 = (eval (Closure(env,e2)) []) in 
											match (t1,t2) with
											| (Closure(env1,I(n1)),Closure(env2,I(n2))) -> if n1=n2 then Closure(env,B(true)) else Closure(env,B(false))
											| (Closure(env1,B(f1)),Closure(env2,B(f2))) -> if f1=f2 then Closure(env,B(true)) else Closure(env,B(false))
											| _ -> raise Error
										end

		| (Closure(env,NotEqual(e1,e2)),s) -> begin 
										let t1 = (eval (Closure(env,e1)) []) in let t2 = (eval (Closure(env,e2)) []) in 
											match (t1,t2) with
											| (Closure(env1,I(n1)),Closure(env2,I(n2))) -> if n1<>n2 then Closure(env,B(true)) else Closure(env,B(false))
											| (Closure(env1,B(f1)),Closure(env2,B(f2))) -> if f1<>f2 then Closure(env,B(true)) else Closure(env,B(false))
											| _ -> raise Error
										end
		(*true: e1>e2 else false*)
		| (Closure(env,Greater(e1,e2)),s) -> begin 
										let t1 = (eval (Closure(env,e1)) []) in let t2 = (eval (Closure(env,e2)) []) in 
											match (t1,t2) with
											| (Closure(env1,I(n1)),Closure(env2,I(n2))) -> if n1>n2 then Closure(env,B(true)) else Closure(env,B(false))
											| _ -> raise Error
										end
		(*true: e1<e2 else false*)
		| (Closure(env,Lesser(e1,e2)),s) -> begin 
										let t1 = (eval (Closure(env,e1)) []) in let t2 = (eval (Closure(env,e2)) []) in 
											match (t1,t2) with
											| (Closure(env1,I(n1)),Closure(env2,I(n2))) -> if n1<n2 then Closure(env,B(true)) else Closure(env,B(false))
											| _ -> raise Error
										end
;;

let krivine (clos3: closure) stack : answer =  let clos_temp = eval clos3 stack in
			match clos_temp with
			| Closure(env,I(x)) -> Int(x)
			| Closure(env,B(x)) -> Bool(x)
			| _ -> Null
;;


(* Explanation *)
(* We can easily see that when we are evaluating function application: 
| (Closure(env,App(e1,e2)),s) ->  eval (Closure(env,e1)) (Closure(env,e2)::s)
Where e1 is an abstraction, and e2 its argument. 
I am storing the closure of current environment and e2(argument) in the stack.
We start evaluating the function e1.
It mean that we would evaluate the argument when it would be needed *)


(*Test Cases*)

(* ------------------------------ TESTCASES 1: FACTORIAL ------------------------------ *)

(* Expression of function *)
Abs(Var("x"),If(Equal(Var("x"),I(0)) , I(1) , Times(Var("x"), App(Var("fact"),Plus(Var("x"),I(-1))))))

(*Its closure is*)
Closure([],Abs(Var("x"),If(Equal(Var("x"),I(0)) , I(1) , Times(Var("x"), App(Var("fact"),Plus(Var("x"),I(-1))))) ))

(*the environment is*)
let env_fact: environment = [(Var("fact"), Closure([],Abs(Var("x"),If(Equal(Var("x"),I(0)) , I(1) , Times(Var("x"), App(Var("fact"),Plus(Var("x"),I(-1))))) )))];;

(* funciton call*)
let funcall_fact: expression = App(Var("fact"),I(5));;

(*Final closure for function call is*)
Closure(env_fact, funcall_fact)

(*Calling Krivin using the Closure and empty stack*)
krivine (Closure(env_fact, funcall_fact)) [];;


(* ------------------------------ TESTCASES 2: FIBONACCI ------------------------------ *)

(* Expression of function *)
Abs(Var("x"), If(Equal(Var("x"),I(0)) , I(0) , If(Equal(Var("x"),I(1)) , I(1) , Plus( App(Var("fib"), Plus(Var("x"),I(-1))), App(Var("fib"), Plus(Var("x"),I(-2))) ) ) ))

(*Its closure is*)
Closure([],Abs(Var("x"), If(Equal(Var("x"),I(0)) , I(0) , If(Equal(Var("x"),I(1)) , I(1) , Plus( App(Var("fib"), Plus(Var("x"),I(-1))), App(Var("fib"), Plus(Var("x"),I(-2))) ) ) )))

(*the environment is*)
let env_fib: environment = [(Var("fib"), Closure([],Abs(Var("x"), If(Equal(Var("x"),I(0)) , I(0) , If(Equal(Var("x"),I(1)) , I(1) , Plus( App(Var("fib"), Plus(Var("x"),I(-1))), App(Var("fib"), Plus(Var("x"),I(-2))) ) ) ))))];;

(* funciton call*)
let funcall_fib: expression = App(Var("fib"),I(6));;

(*Final closure for function call is*)
Closure(env_fib, funcall_fib)

(*Calling Krivin using the Closure and empty stack*)
krivine (Closure(env_fib, funcall_fib)) [];;


