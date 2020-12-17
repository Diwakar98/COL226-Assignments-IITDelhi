type token =
  | FLOAT of (float)
  | OBRAC
  | CBRAC
  | OPARAN
  | CPARAN
  | COMMA
  | SEMICOLON
  | NEWLINE
  | ASSIGN
  | COLON
  | ADD
  | SUBT
  | MULT
  | DIV
  | MAX
  | MIN
  | SUM
  | AVG
  | COUNT
  | ROWCOUNT
  | COLCOUNT
  | ROWSUM
  | COLSUM
  | ROWAVG
  | COLAVG
  | ROWMIN
  | COLMIN
  | ROWMAX
  | COLMAX
  | EXCEPTION

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> string
