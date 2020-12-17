type var = string;;
type symbol = string*int;;
type signature = symbol list;;
let s:signature = [("T",0);("F",0);("AND",2);("OR",2);("NOT",1)];;
type term = V of var | Node of symbol * (term list);;
exception NOT_UNIFIABLE;;

let invalidterm = Node(("AND",2),[V("x")]);;
let validterm = Node(("T",0),[]);;
let validterm1 = Node(("AND",2),[(Node(("OR",2),[V("x");V("y")]));V("z")]);;
let validterm2 = Node(("OR",2),[Node(("AND",2),[V("z");V("w")]);Node(("AND",2),[V("x");V("y")])]);;
let validterm3 = Node(("OR",2),[Node(("AND",2),[V("x");V("x")]);Node(("NOT",1),[Node(("NOT",1),[V("x")])])]);;
let validterm4 = Node(("AND",2),[V("x");V("y")]);;
let s1 = [(V("x"),Node(("AND",2),[V("x1");V("x2")]));(V("y"),Node(("OR",2),[V("y1");V("y2")])); (V("z"),Node(("NOT",1),[V("z1")]));(V("w"),Node(("T",0),[]))];;

let rec check_sig_occurs olist s = match olist with
     | [] -> 0
     | x::xs -> if x=s then 1 + check_sig_occurs xs s
                    else check_sig_occurs xs s;;

(*checks whether a symbol occurs only one time in the signature*)
let rec check_sig_single_count list olist = match list with
          [] -> true
     | x::xs -> if (check_sig_occurs olist x)=1 then check_sig_single_count xs olist
               else false;;
(*checks if any symbol of the signature has negative arity or not*)
let rec check_sig_arity list = match list with
          [] -> true
     | x::xs -> match x with
               (_,n) -> if n>=0 then check_sig_arity xs
                         else false;;

(*checks whether the given signature is valid or not*)
let check_sig sign = check_sig_single_count sign sign && check_sig_arity sign;;

(*return the arity of the given symbol*)
let get_arity sym = match sym with
     (a,b) -> b;;

(*checks if the given term is well defined or not. First it checks if the arity of the symbol is same as the size of the list and then check all the term in the list*)
let rec wfterm term = match term with
     |V(x) -> true
     |Node(sym,tlist) -> if (get_arity sym) = (List.length tlist) then(
                              let result = ref true in
                              for i = 0 to ((List.length tlist)-1) do
                                   result := !result && (wfterm (List.nth tlist i))
                              done;
                              !result
                         )
                         else
                              false;;
(*calculates the height of the tree(term)*)
let rec ht term = match term with
     |V(x) -> 0
     |Node(sym,tlist) -> let h = ref 0 in
                         for i = 0 to ((List.length tlist)-1) do
                              h := max (!h) (ht (List.nth tlist i))
                         done;
                         h:=(!h) + 1;
                         !h;;

(*find the size of the term. i.e. counts the number of variable or the nodes*)
let rec size term = match term with
     |V(x) -> 1
     |Node(sym,tlist) -> let s = ref 0 in
                         for i = 0 to ((List.length tlist)-1) do
                              s := (!s) + (size (List.nth tlist i))
                         done;
                         s:=(!s) + 1;
                         !s;;

(*boolean function to check if the element t is preent in a list or not*)
let rec ispresent ls t = match ls with
     |[] -> false
     |x::xs -> if (t=x) then true else ispresent xs t;;

(*returns the union list of two lists of variables*)
let rec union l1 l2 = match l2 with
     |[] -> l1
     |x::xs -> if (ispresent l1 x) then (union l1 xs)
               else (union (x::l1) xs);;

(*returns the list of the variable in a term*)
let rec vars term = match term with
     |V(x) -> [x]
     |Node(sym,tlist) -> let l = ref [] in
                         for i = 0 to ((List.length tlist)-1) do
                              l := union (!l) (vars (List.nth tlist i))
                         done;
                         !l;;
(*find the varrible in the substitution, if it is present the it returns its substitution, else it returns the same variable*)
let rec subst_helper var s = match s with
     |[]-> V(var)
     |x::xs-> match x with
               (v,term) -> if var = v then term else subst_helper var xs;;

(*function to substitute variables using a given substitution list*)
let rec subst term s = match term with
     |V(x) -> subst_helper x s
     |Node(sym,tlist) -> let l = ref [] in
                         for i = 0 to ((List.length tlist)-1) do
                              l := (!l) @ [subst (List.nth tlist i) s]
                         done;
                         Node(sym,!l);;

(*function to to check if given two terms are unifiable or not, if unifiable then it return the substitution, else raises an exception*)
let rec mgu s t = match (s,t) with
     |(V(x),V(y)) -> if x = y then [] else [(x,t)]
     |(Node(f,sc), Node(g,tc)) -> if (f=g) && (List.length sc = List.length tc) then unify (List.combine sc tc)
                                   else raise NOT_UNIFIABLE
     |((V(x), (Node(a,b))) | ((Node(a,b)), V(x))) -> if (ispresent (vars(Node(a,b))) x) then raise NOT_UNIFIABLE
                                                            else [(x,Node(a,b))]
     and unify (s : (term * term) list) =
       match s with
       | [] -> []
       | (x, y) :: t ->
           let t2 = unify t in
           let t1 = mgu (subst x t2) (subst y t2) in
           t1 @ t2;;