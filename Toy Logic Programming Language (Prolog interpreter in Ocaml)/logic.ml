type var = string;;
type const = string;;
type symbol = S of string;;
type signature = symbol list;;
type term = V of var | C of const | FORMULA of symbol * (term list);;
type atomic_formula = FORMULA of symbol * (term list);;
type goal = G of atomic_formula list;;
type body = atomic_formula list;;
type head = AF of atomic_formula;;
type rule = head*body;;
type clause = F of head | R of rule;;
type program  = P of clause list;;
type substitution = ( var * term ) list;;
type env = int * substitution;;
type path = goal list * env;;

let empty_result = ref true ;;
let result_firstline = ref false;;
let result_num = ref 0;;

type 'a decide = True of 'a| False;;

let term1:term = FORMULA((S("motherOf")),[V("X");V("M")]);;
let term2:term = FORMULA((S("motherOf")),[V("M");V("GM")]);;
let clause1= R((AF(FORMULA(S("grandMotherOf"),[V("X");V("GM")]))),([FORMULA(S("fatherOf"),[V("X");V("F")]);FORMULA(S("motherOf"),[V("F");V("GM")])]));;
let clause2= R((AF(FORMULA(S("grandMotherOf"),[V("X");V("GM")]))),([FORMULA(S("motherOf"),[V("X");V("M")]);FORMULA(S("motherOf"),[V("M");V("GM")])]));;
let body1 = [FORMULA((S("motherOf")),[V("X");V("M")]); FORMULA((S("motherOf")),[V("M");V("GM")])];;

let s2 = [("X",C("judy"))];;
let s1 = [("X",V("tom"))];;

exception ERROR;;

let rec ispresent ls t = match ls with
     |[] -> false
     |x::xs -> if (t=x) then true else ispresent xs t;;


let rec union l1 l2 = match l2 with
     |[] -> l1
     |x::xs -> if (ispresent l1 x) then (union l1 xs)
               else (union (x::l1) xs);;


let rec vars term = match term with
     |C(x) -> []
     |V(x) -> [x]
     |FORMULA(sym,tlist) -> let l = ref [] in
                         for i = 0 to ((List.length tlist)-1) do
                              l := union (!l) (vars (List.nth tlist i))
                         done;
                         !l;;

let rec get_var term = match term with
     |[]  -> []
     |V(x)::xs -> V(x)::get_var xs
     |FORMULA(a,b)::xs -> (get_var b)@(get_var xs)
     |_::xs -> get_var xs;;

let rec get_vars_from_body body =  match body with
     |[]->[]
     |FORMULA(a,b)::xs->(get_var b) @ (get_vars_from_body xs);;

let rec subst_helper var s = match s with
     |[]-> V(var)
     |x::xs-> match x with
               (v,term) -> if var = v then term else subst_helper var xs;;

let rec subst term s = match term with
     |C(x) -> term
     |V(x) -> subst_helper x s
     |FORMULA(sym,tlist) -> let l = ref [] in
                         for i = 0 to ((List.length tlist)-1) do
                              l := (!l) @ [subst (List.nth tlist i) s]
                         done;
                         FORMULA(sym,!l);;

let rec subst_tlist tlist s = match tlist with
     |[]->[]
     |x::xs -> (subst x s) :: (subst_tlist xs s);;

let subst_af af s = match af with
     |FORMULA(sym,list) -> FORMULA(sym, subst_tlist list s);;

let rec subst_body b s = match b with
     |[]->[]
     |x::xs -> (subst_af x s) :: (subst_body xs s);;

let subst_clause c s = match c with
     |F(AF(af)) -> F(AF((subst_af af s)))
     |R((AF(af),b)) -> R((AF(subst_af af s)),(subst_body b s));;

let clause1 = F(AF(FORMULA(S("motherOf"),[V("X");V("M")])));;
let goal1 = G([FORMULA(S("motherOf"),[C("tom");C("judy")])]);;

let rec print_tlist tlist = match tlist with
     |[]-> print_string "";
     |V(x)::xs -> print_string x; print_string " - "; print_tlist xs;
     |C(x)::xs -> print_string x; print_string " - "; print_tlist xs;
     |FORMULA(S(s),tlist)::xs -> print_string s; print_string " - "; print_tlist tlist; print_tlist xs;;

let rec print_term term = match term with
     | V(x) -> print_string x;
     | C(x) -> print_string x;
     | FORMULA(S(x),tlist) -> print_string x; print_string " "; print_tlist tlist;;

let print_af af = match af with
     |FORMULA(S(s),tlist)-> print_string s; print_string " - "; print_tlist tlist; print_string "\n";;

let rec print_subst sub = match sub with
     |[]-> print_string "\n";
     |(var,term)::xs -> print_string var; print_term term; print_string "\n"; print_subst xs;;

let rec print_body b = match b with
     |[]-> print_string "";
     |x::xs-> print_af x; print_body xs;;

let print_clause c = match c with
     |F(AF(af)) -> print_af af;
     |R((AF(af)),(body))-> print_af af; print_body body;;

let rec print_goals g = match g with
     |G([])->print_string "";
     |G(x::xs)->print_af x; print_goals (G(xs));;

let rec print_program p = match p with
     |P([]) -> print_string "";
     |P(x::xs) -> print_clause x; print_program (P(xs));;

let rec print_vlist vlist = match vlist with
     |[] -> print_string "";
     |V(x)::xs -> print_string "V("; print_string x; print_string ") "; print_vlist xs
     |C(x)::xs -> print_string "C("; print_string x; print_string ") "; print_vlist xs
     |x::xs -> print_string "ELSE\n";;

let rec find_solution clist sol_clause = match clist with
  |   []      ->  False
  |   x::xs    ->  (*print_string "((((()))))";
                  print_clause x;
                  print_string "((((()))))";*)
                  let temp = sol_clause x in
                   match temp with
                      | False -> find_solution xs sol_clause
                      | True(x) -> temp;;

let rec retrieve_helper2 x s ss l = match s with
     | [] -> x
     | (v,t)::b -> let b2 = List.exists(fun element -> t = element) l in
                         if V(v) = x && b2 = false then
                              match t with
                              |   V(m)    ->  retrieve_helper2 t ss ss (t :: l)
                              |   _       ->  t
                         else
                              retrieve_helper2 x b ss l;;

let rec retrieve_helper1 x s  = match s with
     |   [] ->  []
     |   (c, C(d))::b -> if (x = V(c)) then
                              C(d) :: retrieve_helper1 x b
                         else
                              retrieve_helper1 x b
     |   a::b ->  retrieve_helper1 x b;;

let retrieve t subst =
    let h = retrieve_helper1 t subst in
    if List.length h = 0 then
        match t with
            | V(p)  ->  retrieve_helper2 t subst subst [t]
            | _     ->  t
    else
        match h with
            |   []      ->  retrieve_helper2 t subst subst [t]
            |   a::b    ->  a;;

let rec replace_helper2 term sigma = match term with
     | V(a) -> (retrieve term sigma)
     | C(a) -> term
     | FORMULA(a,b) -> let rec fn list = match list with
                         | [] -> []
                         | x::xs -> (replace_helper2 term sigma) :: (fn xs);
                    in FORMULA(a,(fn b));;

let rec replace_helper1 tlist = match tlist with
     | [] -> []
     | x::xs -> (replace_helper2 x s1) :: (replace_helper1 xs);;

let replace tlist subst  = replace_helper1 tlist;;

let rec copy_from_tlist tlist = match tlist with
     | [] -> []
     | V(x)::xs -> V(x^"'") :: copy_from_tlist xs
     | C(x)::xs -> C(x) :: copy_from_tlist xs
     | FORMULA(sym,tlist1)::xs -> (FORMULA(sym, copy_from_tlist tlist1)) :: (copy_from_tlist xs);;

let copy_from_af af = match af with
     | FORMULA(sym,tlist) -> FORMULA(sym, copy_from_tlist tlist);;

let rec copy_from_aflist aflist = match aflist with
     | [] -> []
     | x::xs -> (copy_from_af x) :: (copy_from_aflist xs);;

let copy_from_clause clause = match clause with
     | F(AF(af)) -> F(AF(copy_from_af af))
     | R(((AF(af)),(aflist))) -> R(((AF(copy_from_af af)),(copy_from_aflist aflist)));;

let rec create_copy clist = match clist with
     | [] -> []
     | x::xs -> (copy_from_clause x) :: (create_copy xs);;

(* //OLD MGU
     let rec mgu s t = match (s,t) with
     |((V(x),C(y)) | (C(y),V(x))) -> [(x,C(y))]
     |(C(x),C(y)) -> if (x=y) then [] else raise NOT_UNIFIABLE
     |((C(x),(FORMULA(a,b))) | ((FORMULA(a,b)),C(x))) -> raise NOT_UNIFIABLE
     |(V(x),V(y)) -> if (x=y) then [] else [(x,t)]
     |(FORMULA(f,sc), FORMULA(g,tc)) -> if (f=g) && (List.length sc = List.length tc) then unify (List.combine sc tc)
                                   else raise NOT_UNIFIABLE
     |((V(x),(FORMULA(a,b))) | ((FORMULA(a,b)),V(x))) -> if (ispresent (vars(FORMULA(a,b))) x) then raise NOT_UNIFIABLE
                                                            else [(x,FORMULA(a,b))]
     and unify (s : (term * term) list) =
       match s with
       | [] -> []
       | (x, y) :: t ->
           let t2 = unify t in
           let t1 = mgu (subst x t2) (subst y t2) in
           t1 @ t2;; *)

let rec mgu (t1, t2 : term * term) (subst : substitution) =
     let r1 = retrieve t1 subst in
     let r2 = retrieve t2 subst in
     let rec unify (x1:term) (x2:term) (subst:substitution) = match (x1, x2) with
          | (C(a),C(b)) -> if (a = b) then True(subst) else False
          | (V(a),b) -> True((a,b)::subst)
          | (b,V(a)) -> True((a,b)::subst)
          | (FORMULA(a,b), FORMULA(c,d)) -> if ((a = c) && (List.length b = List.length d)) then
                    (
                       let rec func (b:term list) (d:term list) (subst:substitution) = match (b,d) with
                              | ([],[]) -> True(subst)
                              | ([],x::xs) | (x::xs,[]) -> False
                              | (e::f,g::h) -> let t = mgu (e, g) subst in
                                                  match t with
                                                  | False -> False
                                                  | True(d) -> (func (replace f d) (replace h d) d)
                       in
                       func b d subst
                    )
                   else False
          | (_,_) -> False
    in
    unify r1 r2 subst ;;

(*
let rec solve_body b g = match (b,g) with
     |([],G((FORMULA(sym2,tlist2))::xs))->true
     |((FORMULA(sym1,tlist1))::xs,G((FORMULA(sym2,tlist2))::gs))->begin
                              let t1: term = FORMULA(sym1,tlist1) in
                              let t2: term = FORMULA(sym2,tlist2) in
                              try
                                   let s1 = mgu t1 t2 in
                                   let bnew = subst_body xs s1 in
                                   solve_body bnew g
                              with NOT_UNIFIABLE -> false
                              end;; *)


let print_ans vlist (subst : substitution) =
     let rec helper t g = match t with
          | [] -> print_string ""; flush stdout; g
          | a::b -> match a with
                    | (x,f) -> (
                         match (retrieve f subst) with
                         | V(v) -> helper b g
                         | FORMULA(sym, tlist) -> helper b g
                         | C(v) -> if ((List.exists(fun element -> V(x) = element) vlist)==true) then
                                        (
                                        empty_result := false;
                                        if ((List.length vlist - 1) = !result_num) then
                                             (
                                                  result_num := (!result_num) +1;
                                                  print_string (x ^ " = " ^ v ^ ".");
                                                  flush stdout;
                                                  helper b 1
                                             )
                                        else
                                             (
                                                  result_num := (!result_num) +1;
                                                  print_string (x ^ " = " ^ v ^ ",\n");
                                                  flush stdout;
                                                  helper b 1
                                             )
                                        )
                                   else
                                        (helper b 1)
                         )
                    (* | (_,_) ->  print_string ""; flush stdout; helper b g *)
                    in
     let result = (helper subst 0)
          in
    if (result == 0) then
                         True(subst)
                    else
                         False;;

let solve_af a1 a2 subst = match (a1,a2) with
     | (FORMULA(w,x),FORMULA(y,z)) -> if ((w = y) && (List.length x = List.length z)) then
                         (
                              let rec func l m subst1 = match (l,m) with
                                   | ([],[]) -> True(subst1)
                                   | ([],e::f) | (e::f,[]) -> False
                                   | (e::f,g::h) -> let t = (mgu (e,g) subst1) in
                                             match t with
                                             | False -> False
                                             | True(subst2) -> let s1 = replace f subst2 in
                                                               let s2 = replace h subst2 in
                                                               func s1 s2 subst2
                              in
                              func x z subst
                         )
                         else False;;

let solve_head data af1 head subst= match head with
     | AF(af2) -> solve_af af1 af2 subst;;

let rec solve_clause vlist clist aflist subst copyclist = match aflist with
     (*c = grandmother clause*)
     (*clist = original program*)
     (*aflist = motherof clause*)
     | [] -> True(subst)
     | FORMULA(sym1,c1)::g_tail ->  match copyclist with
          | F(AF(FORMULA(sym2,c2))) ->
               (
                    let g_head = FORMULA(sym1, replace c1 subst)
                         in
                    let a = AF(FORMULA(sym2, replace c2 subst))
                         in
                    let t = solve_head clist g_head a subst
                         in
                    match t with
                         |False -> False
                         |True(x) -> solve_goals vlist clist x (g_tail)
               )

          | R(((AF(FORMULA(sym2,c2))),(b))) ->
               (
                    let a = AF(FORMULA(sym2, replace c2 subst))
                         in
                    let g_head = FORMULA(sym1, replace c1 subst)
                         in
                    let t = solve_head clist g_head a subst
                         in
                         match t with
                              | False -> False
                              | True(x) -> solve_goals vlist clist x (b@g_tail)
               )
     and

     solve_goals vlist data subst goals  = match goals with
     |[] ->
          result_num:=0;
          if (!result_firstline == true)  then
               (
                    result_firstline := false;
                    print_ans vlist subst;

               )
          else(
                    print_string " ?- ";
                    flush stdout;
                    let y = read_line() in
                    if (y = ";") then
                         (
                              print_ans vlist subst
                         )
                    else
                         (
                              True(subst)
                         )
               )

     |x::xs -> let clist1 = create_copy data in
               (* print_str/nvzing "-------\n"; *)
               (* print_program (P(clist1)); *)
               (* print_string "-------\n"; *)
               find_solution clist1 (solve_clause vlist data goals subst);;

let rec solve_program p g = match (p,g) with
     |(P(a),G(b)) -> let vlist = (get_vars_from_body b) in
                     (* print_string "VARS=["; print_vlist (get_vars_from_body b); print_string "]\n"; *)
                    let temp = solve_goals vlist a [] b
                         in
                    match temp with
                         | False -> if (!empty_result == true) then
                                        (
                                             print_string "False\n";
                                             flush stdout;
                                        )
                                    else
                                        (
                                             print_string "\nTrue\n";
                                             flush stdout;
                                        )
                         | True(x) ->   (
                                             print_string "\nTrue\n";
                                             flush stdout;
                                        ) ;;