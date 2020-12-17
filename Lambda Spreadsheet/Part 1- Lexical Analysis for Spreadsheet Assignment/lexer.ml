# 2 "lexer.mll"
 
     type token =                  (*Defining various types of possible tokens*)
     | FLOAT of float
     | SPACE
     | OPARAN
     | CPARAN
     | OBRAC
     | CBRAC
     | COMMA
     | COLON
     | INDEX
     | RANGE
     | SUM
     | AVG
     | MIN
     | MAX
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
     | ADD
     | SUBT
     | MULT
     | DIV
     | ASSIGN
     | SEMICOLON
     | NEWLINE
     | EXCEPTION
     exception Eof       (*Defining  Exception*)

# 40 "lexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base =
   "\000\000\225\255\226\255\000\000\001\000\000\000\000\000\001\000\
    \001\000\000\000\247\255\248\255\249\255\250\255\251\255\252\255\
    \253\255\254\255\000\000\046\000\056\000\001\000\068\000\078\000\
    \088\000\098\000\108\000\118\000\246\255\000\000\002\000\244\255\
    \238\255\000\000\000\000\000\000\000\000\243\255\241\255\240\255\
    \003\000\242\255\004\000\239\255\100\000\112\000\012\000\031\000\
    \237\255\113\000\094\000\096\000\103\000\098\000\106\000\103\000\
    \235\255\111\000\233\255\001\000\231\255\102\000\113\000\229\255\
    \227\255\105\000\129\000\128\000\111\000\113\000\120\000\115\000\
    \124\000\119\000\236\255\127\000\234\255\004\000\232\255\117\000\
    \129\000\230\255\228\255";
  Lexing.lex_backtrk =
   "\255\255\255\255\255\255\029\000\029\000\029\000\029\000\029\000\
    \029\000\010\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\029\000\029\000\029\000\255\255\255\255\255\255\
    \000\000\255\255\255\255\000\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255";
  Lexing.lex_default =
   "\002\000\000\000\000\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\000\000\255\255\255\255\000\000\
    \000\000\255\255\255\255\255\255\255\255\000\000\000\000\000\000\
    \255\255\000\000\255\255\000\000\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\000\000\255\255\000\000\255\255\255\255\000\000\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\000\000\255\255\000\000\255\255\000\000\255\255\
    \255\255\000\000\000\000";
  Lexing.lex_trans =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\010\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \017\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \016\000\015\000\000\000\020\000\012\000\020\000\026\000\026\000\
    \018\000\019\000\019\000\019\000\019\000\019\000\019\000\019\000\
    \019\000\019\000\009\000\011\000\000\000\028\000\000\000\000\000\
    \000\000\008\000\034\000\004\000\006\000\030\000\031\000\032\000\
    \060\000\040\000\033\000\078\000\036\000\007\000\039\000\065\000\
    \044\000\043\000\003\000\005\000\037\000\042\000\035\000\029\000\
    \038\000\041\000\047\000\014\000\023\000\013\000\022\000\022\000\
    \022\000\022\000\022\000\022\000\022\000\022\000\022\000\022\000\
    \021\000\022\000\022\000\022\000\022\000\022\000\022\000\022\000\
    \022\000\022\000\023\000\048\000\022\000\022\000\022\000\022\000\
    \022\000\022\000\022\000\022\000\022\000\022\000\024\000\024\000\
    \024\000\024\000\024\000\024\000\024\000\024\000\024\000\024\000\
    \025\000\024\000\024\000\024\000\024\000\024\000\024\000\024\000\
    \024\000\024\000\025\000\024\000\024\000\024\000\024\000\024\000\
    \024\000\024\000\024\000\024\000\026\000\027\000\027\000\027\000\
    \027\000\027\000\027\000\027\000\027\000\027\000\026\000\027\000\
    \027\000\027\000\027\000\027\000\027\000\027\000\027\000\027\000\
    \045\000\050\000\061\000\052\000\059\000\057\000\053\000\054\000\
    \055\000\046\000\062\000\056\000\058\000\049\000\064\000\063\000\
    \066\000\079\000\068\000\051\000\070\000\077\000\075\000\071\000\
    \072\000\080\000\073\000\074\000\076\000\082\000\067\000\081\000\
    \000\000\000\000\000\000\000\000\069\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \001\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000";
  Lexing.lex_check =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\000\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\000\000\255\255\000\000\000\000\000\000\018\000\021\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\255\255\009\000\255\255\255\255\
    \255\255\000\000\007\000\000\000\000\000\008\000\030\000\029\000\
    \059\000\006\000\007\000\077\000\035\000\000\000\033\000\003\000\
    \004\000\042\000\000\000\000\000\036\000\005\000\007\000\008\000\
    \034\000\040\000\046\000\000\000\019\000\000\000\019\000\019\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\019\000\019\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\022\000\047\000\022\000\022\000\022\000\022\000\
    \022\000\022\000\022\000\022\000\022\000\022\000\023\000\023\000\
    \023\000\023\000\023\000\023\000\023\000\023\000\023\000\023\000\
    \024\000\024\000\024\000\024\000\024\000\024\000\024\000\024\000\
    \024\000\024\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\025\000\025\000\026\000\026\000\026\000\026\000\
    \026\000\026\000\026\000\026\000\026\000\026\000\027\000\027\000\
    \027\000\027\000\027\000\027\000\027\000\027\000\027\000\027\000\
    \044\000\045\000\049\000\045\000\050\000\051\000\052\000\053\000\
    \054\000\044\000\049\000\055\000\057\000\045\000\061\000\062\000\
    \065\000\067\000\066\000\045\000\066\000\068\000\069\000\070\000\
    \071\000\067\000\072\000\073\000\075\000\079\000\066\000\080\000\
    \255\255\255\255\255\255\255\255\066\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255";
  Lexing.lex_base_code =
   "";
  Lexing.lex_backtrk_code =
   "";
  Lexing.lex_default_code =
   "";
  Lexing.lex_trans_code =
   "";
  Lexing.lex_check_code =
   "";
  Lexing.lex_code =
   "";
}

let rec token lexbuf =
   __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
let
# 45 "lexer.mll"
                     i
# 200 "lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 45 "lexer.mll"
                         (FLOAT (float_of_string i))
# 204 "lexer.ml"

  | 1 ->
# 46 "lexer.mll"
                         (SPACE)
# 209 "lexer.ml"

  | 2 ->
# 47 "lexer.mll"
                         (OPARAN)
# 214 "lexer.ml"

  | 3 ->
# 48 "lexer.mll"
                         (CPARAN)
# 219 "lexer.ml"

  | 4 ->
# 49 "lexer.mll"
                         (OBRAC)
# 224 "lexer.ml"

  | 5 ->
# 50 "lexer.mll"
                         (CBRAC)
# 229 "lexer.ml"

  | 6 ->
# 51 "lexer.mll"
                         (COMMA)
# 234 "lexer.ml"

  | 7 ->
# 52 "lexer.mll"
                         (SEMICOLON)
# 239 "lexer.ml"

  | 8 ->
# 53 "lexer.mll"
                         (NEWLINE)
# 244 "lexer.ml"

  | 9 ->
# 54 "lexer.mll"
                         (ASSIGN)
# 249 "lexer.ml"

  | 10 ->
# 55 "lexer.mll"
                         (COLON)
# 254 "lexer.ml"

  | 11 ->
# 56 "lexer.mll"
                         (ADD)
# 259 "lexer.ml"

  | 12 ->
# 57 "lexer.mll"
                         (MULT)
# 264 "lexer.ml"

  | 13 ->
# 58 "lexer.mll"
                         (DIV)
# 269 "lexer.ml"

  | 14 ->
# 59 "lexer.mll"
                         (MAX)
# 274 "lexer.ml"

  | 15 ->
# 60 "lexer.mll"
                         (MIN)
# 279 "lexer.ml"

  | 16 ->
# 61 "lexer.mll"
                         (SUM)
# 284 "lexer.ml"

  | 17 ->
# 62 "lexer.mll"
                         (AVG)
# 289 "lexer.ml"

  | 18 ->
# 63 "lexer.mll"
                         (COUNT)
# 294 "lexer.ml"

  | 19 ->
# 64 "lexer.mll"
                         (ROWCOUNT)
# 299 "lexer.ml"

  | 20 ->
# 65 "lexer.mll"
                         (COLCOUNT)
# 304 "lexer.ml"

  | 21 ->
# 66 "lexer.mll"
                         (ROWSUM)
# 309 "lexer.ml"

  | 22 ->
# 67 "lexer.mll"
                         (COLSUM)
# 314 "lexer.ml"

  | 23 ->
# 68 "lexer.mll"
                         (ROWAVG)
# 319 "lexer.ml"

  | 24 ->
# 69 "lexer.mll"
                         (COLAVG)
# 324 "lexer.ml"

  | 25 ->
# 70 "lexer.mll"
                         (ROWMIN)
# 329 "lexer.ml"

  | 26 ->
# 71 "lexer.mll"
                         (COLMIN)
# 334 "lexer.ml"

  | 27 ->
# 72 "lexer.mll"
                         (ROWMAX)
# 339 "lexer.ml"

  | 28 ->
# 73 "lexer.mll"
                         (COLMAX)
# 344 "lexer.ml"

  | 29 ->
# 74 "lexer.mll"
               (EXCEPTION)
# 349 "lexer.ml"

  | 30 ->
# 75 "lexer.mll"
                (raise Eof)
# 354 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_token_rec lexbuf __ocaml_lex_state

;;

# 76 "lexer.mll"
 
     let main () = begin
          try            (*Exception handling for end of file exception*)
            let lexbuf = Lexing.from_channel stdin in
                 while true do
                   let result = token lexbuf in
                     match result with
                         (*Printing whatever the lexer matches*)
                     |   FLOAT(i)  -> Printf.printf "FLOAT(%f)\n" i
                     |   COLON     -> Printf.printf "COLON\n"
                     |   SEMICOLON -> Printf.printf "SEMICOLON\n"
                     |   OPARAN    -> Printf.printf "OPENPARAN\n"
                     |   CPARAN    -> Printf.printf "CLOSEPARAN\n"
                     |   OBRAC     -> Printf.printf "OPENBRAC\n"
                     |   CBRAC     -> Printf.printf "CLOSEBRAC\n"
                     |   SUM       -> Printf.printf "SUM\n"
                     |   AVG       -> Printf.printf "AVG\n"
                     |   MAX       -> Printf.printf "MAX\n"
                     |   MIN       -> Printf.printf "MIN\n"
                     |   COMMA     -> Printf.printf "COMMA\n"
                     |   COUNT     -> Printf.printf "COUNT\n"
                     |   ADD       -> Printf.printf "ADD\n"
                     |   SUBT      -> Printf.printf "SUBT\n"
                     |   MULT      -> Printf.printf "MULT\n"
                     |   DIV       -> Printf.printf "DIV\n"
                     |   ASSIGN    -> Printf.printf "ASSIGN\n"
                     |   NEWLINE   -> Printf.printf ""        (*Ignoring newlines*)
                     |   SPACE     -> Printf.printf ""        (*  Ignoring spaces*)
                     |   _         -> Printf.printf "(Token Not Recognised)\n"      (*Ignoring other character*)
                 done
                 with
                    Eof -> exit 0 (*If the Eof exception is raised the exit 0, which means termnitate lexing.*)
            end;;
     main();;       (*Calling main function to execute it*)

# 397 "lexer.ml"