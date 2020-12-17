%{
     open Logic
%}
%token <int> INT
%token <string> STRING
%token <string> VAR
%token COLONDASH SEMICOLON BAR LPAREN RPAREN LBRAC RBRAC QUOTE COMMA FULLSTOP ERROR EOF EQUAL
%token GREATER LESSER IS PLUS MINUS DIV MUL
%start main_goal
%start main_program
%start filename
%type <Logic.goal> main_goal
%type <Logic.program> main_program
%type <string> filename
%%

filename:
     | LBRAC QUOTE STRING FULLSTOP STRING QUOTE RBRAC FULLSTOP {$3 ^ "." ^ $5}
     ;

main_goal:
     | goal FULLSTOP {G($1)}
     ;

goal:
     | atomic_formula {[$1]}
     | atomic_formula COMMA body {$1::$3}
     | atomic_formula SEMICOLON body {$1::$3}
     ;

main_program:
     | program EOF { P($1) }
     ;

program:
     | clause {[$1]}
     | clause program {$1::$2}
     ;

clause:
     | fact    {F($1)}
     | rule    {R($1)}
     ;

fact:
     | head FULLSTOP   {$1}
     ;

rule:
     | head COLONDASH body FULLSTOP {($1,$3)}
     ;

head:
     | atomic_formula {AF($1)}
     ;

body:
     | atomic_formula {[$1]}
     | atomic_formula COMMA body {$1::$3}
     | atomic_formula SEMICOLON body {$1::$3}
     ;

atomic_formula:
     | STRING LPAREN tlist RPAREN {FORMULA(S($1),$3)}
     ;

tlist:
     | term COMMA tlist {$1::$3}
     | term    {[$1]}
     ;

term:
     | VAR     {V($1)}
     | STRING  {C($1)}
     | STRING LPAREN tlist RPAREN {FORMULA(S($1),$3)}
     ;