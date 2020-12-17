grandMotherOf(X,GM) :-
motherOf(X,M),
motherOf(M,GM).

grandMotherOf(X,GM) :-
fatherOf(X,F),
motherOf(F,GM).

grandMotherOf(judy,joe).
grandMotherOf(judy,joe).

grandFatherOf(X,GM) :-
motherOf(X,M),
fatherOf(M,GM).

grandFatherOf(X,GM) :-
fatherOf(X,F),
fatherOf(F,GM).

brotherOF(A,B) :-
fatherOf(A,P),
fatherOf(B,P).

brotherOF(A,B) :-
motherOf(A,P),
motherOf(B,P).

fatherOf(blue,red).
fatherOf(blue,yellow).
fatherOf(blue,green).
fatherOf(judy,jacky).
fatherOf(tom,deck).
fatherOf(deck,harry).
fatherOf(tom,tarry).
fatherOf(jane,harry).
fatherOf(jacky,john).
fatherOf(mary,john).
fatherOf(harry,john).

motherOf(blue,black).
motherOf(yellow,green).
motherOf(pink,green).
motherOf(jacky,joe).
motherOf(jimmy,joe).
motherOf(sheru,judy).
motherOf(gauri,judy).
motherOf(judy,jimmy).
motherOf(tom,judy).
motherOf(dick,mary).
motherOf(jane,mary).

save(dad,mom,bro,sis,uncle).