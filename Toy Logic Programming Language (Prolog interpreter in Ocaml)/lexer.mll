{
     open Parser        (* The type token is defined in parser.mli *)
}
let string = ['a'-'z'] ['_' 'a'-'z' 'A'-'Z' '0'-'9']*
let var = ['A'-'Z'] ['_' 'a'-'z' 'A'-'Z' '0'-'9']*
let int = (['-''+']?['1'-'9']['0'-'9']*) | (['0'])

rule token = parse
       | [' ' '\t' '\n'] { token lexbuf }
       | ":-"            { COLONDASH }
       | ';'             { SEMICOLON }
       | '('             { LPAREN }
       | ')'             { RPAREN }
       | '['             { LBRAC }
       | ']'             { RBRAC }
       | '''             { QUOTE }
       | ','             { COMMA }
       | '|'             { BAR }
       | '.'             { FULLSTOP }
       | '='             { EQUAL }
       | '>'             { GREATER }
       | '<'             { LESSER}
       | "is"            { IS }
       | '+'             { PLUS }
       | '-'             { MINUS }
       | '*'             { MUL }
       | '/'             { DIV }
       | string as s     { STRING (s) }
       | var as s        { VAR (s) }
       | int as n        { INT (int_of_string n) }
       | eof             { EOF }
       | _               { ERROR }