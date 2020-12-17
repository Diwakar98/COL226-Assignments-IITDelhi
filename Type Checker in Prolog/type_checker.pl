/*ARITHMETIC*/
hastype(Gamma,add(A,B),int):-
     hastype(Gamma,A,int),
     hastype(Gamma,B,int), !.

hastype(Gamma,sub(A,B),int):-
     hastype(Gamma,A,int),
     hastype(Gamma,B,int), !.

hastype(Gamma,mul(A,B),int):-
     hastype(Gamma,A,int),
     hastype(Gamma,B,int), !.

hastype(Gamma,div(A,B),int):-
     hastype(Gamma,A,int),
     hastype(Gamma,B,int), !.

hastype(Gamma,incr(A),int):-
     hastype(Gamma,A,int), !.

hastype(Gamma,decr(A),int):-
     hastype(Gamma,A,int), !.

/*BOOLEAN*/
hastype(Gamma,and(A,B),bool):-
     hastype(Gamma,A,bool),
     hastype(Gamma,B,bool), !.

hastype(Gamma,or(A,B),bool):-
     hastype(Gamma,A,bool),
     hastype(Gamma,B,bool), !.

hastype(Gamma,not(A),bool):-
     hastype(Gamma,A,bool), !.

hastype(Gamma,xor(A,B),bool):-
     hastype(Gamma,A,bool),
     hastype(Gamma,B,bool), !.

hastype(Gamma,xnor(A,B),bool):-
     hastype(Gamma,A,bool),
     hastype(Gamma,B,bool), !.

hastype(Gamma,nand(A,B),bool):-
     hastype(Gamma,A,bool),
     hastype(Gamma,B,bool), !.

hastype(Gamma,nor(A,B),bool):-
     hastype(Gamma,A,bool),
     hastype(Gamma,B,bool), !.

/*COMPARISON OVER ARITHMETIC*/
hastype(Gamma,equal(A,B),bool):-
     hastype(Gamma,A,T),
     hastype(Gamma,B,T), !.

hastype(Gamma,greater(A,B),bool):-
     hastype(Gamma,A,int),
     hastype(Gamma,B,int), !.

hastype(Gamma,lesser(A,B),bool):-
     hastype(Gamma,A,int),
     hastype(Gamma,B,int), !.

hastype(Gamma,greaterorequal(A,B),bool):-
     hastype(Gamma,A,int),
     hastype(Gamma,B,int), !.

hastype(Gamma,lesserorequal(A,B),bool):-
     hastype(Gamma,A,int),
     hastype(Gamma,B,int), !.

/*IF THEN ELSE*/
hastype(Gamma,if(A,B,C),T):-
     hastype(Gamma,A,bool),
     hastype(Gamma,B,T),
     hastype(Gamma,C,T), !.

/*TUPLE*/
hastype(Gamma,(E|RestE),(T,RestT)):-
     hastype(Gamma,E,T),
     hastype(Gamma,RestE,RestT), !.

hastype(Gamma,(E1,E2),(T1,T2)):-
     hastype(Gamma,E1,T1),
     hastype(Gamma,E2,T2), !.
hastype(Gamma,[],[]).
hastype(Gamma,[E|RestE],[T|RestT]):-
     write(E),
     hastype(Gamma,E,T),
     hastype(Gamma,RestE,RestT), !.


/*LOOKING IN GAMMA*/
hastype([(A,T)|Rest],A,T).
hastype([(A,T1)|Rest],B,T2):-
     not(A=B),
     hastype(Rest,B,T2), !.

/*LET-IN*/
hastype(Gamma,letin(D,E),T):-
     typeElaborates(Gamma,D,Gamma1),
     append(Gamma1,Gamma,Gamma2),
     hastype(Gamma2,E,T), !.

append(Gamma,(D,T1),[(D,T1)|Gamma]).
append([],A,A).
append(A,[],A).
append([X|Xs],B,[X|C]) :- append(Xs,B,C).

/*FUNCTION*/
hastype(Gamma,func(A,B),arrow(T1,T2)):-
     hastype(Gamma,A,T1),
     hastype(Gamma,B,T2), !.


/*TYPE ELABORATE*/
typeElaborates(Gamma,def(A,B),[(A,T)]):-
     hastype(Gamma,B,T), !.

typeElaborates(Gamma,sequential(D1,D2),Gamma4):-
     typeElaborates(Gamma,D1,Gamma1),
     append(Gamma1,Gamma,Gamma2),
     typeElaborates(Gamma2,D2,Gamma3),
     append(Gamma3,Gamma1,Gamma4), !.

typeElaborates(Gamma,parallel(D1,D2),Gamma3):-
     typeElaborates(Gamma,D1,Gamma1),
     typeElaborates(Gamma,D2,Gamma2),
     union(Gamma1,Gamma2,Gamma3), 
     disjoint(Gamma1,Gamma2), !.

typeElaborates(Gamma,local(D1,D2),Gamma3):-
     typeElaborates(Gamma,D1,Gamma1),
     append(Gamma1,Gamma,Gamma2),
     typeElaborates(Gamma2,D2,Gamma3), !.

disjoint([],L).
disjoint(L,[]).
disjoint([(X,T)|Rest],L):-
     checkifneedtobeadded((X,T),L),
     disjoint(Rest,L).

union([],L,L).
union(L,[],L).

union([(X,T)|Xs],L,[(X,T)|Rest]):-
     checkifneedtobeadded((X,L),L),
     union(Xs,L,Rest).

union([(X,T)|Xs],L,Rest):-
     not(checkifneedtobeadded((X,T),L)),
     union(Xs,L,Rest).

checkifneedtobeadded((X,T),[]).
checkifneedtobeadded((X,T),[(X,T)|Rest]):-false.
checkifneedtobeadded((X,T),[(Y,T1)|Rest]):-
     not(X=Y),
     checkifneedtobeadded((X,T),Rest).

/*PROJECTION*/
hastype(Gamma,proj((X,Rest),1),T):-     
     hastype(Gamma,X,T), !.

hastype(Gamma,proj((X),1),T):-     
     hastype(Gamma,X,T), !.

hastype(Gamma,proj((X,Rest),N),T):-
     NewN is integer(N) - integer(1),
     hastype(Gamma,proj(Rest,NewN),T), !.


/*FUNCION APPLICATION*/
hastype(Gamma,funapply(F,E),B):-
     hastype(Gamma,E,T),
     hastype(Gamma,F,arrow(T,B)), !.

/*FUNCTION ABSTRACTION*/
hastype(Gamma,funabs(X,E),arrow(T2,T1)):-
     hastype(Gamma1,E,T1),
     hastype(Gamma1,X,T2), !.

hastype(Gamma,funabs(X,E),arrow(T2,T1)):-
     hastype(Gamma,E,T1),
     hastype(Gamma1,X,T2), !.

hastype(Gamma,A,int):- integer(A), !.
hastype(Gamma,A,float):- float(A), !.
hastype(Gamma,A,bool):- A = true, !.
hastype(Gamma,A,bool):- A = false, !.

