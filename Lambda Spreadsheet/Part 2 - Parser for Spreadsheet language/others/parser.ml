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

open Parsing;;
let _ = parse_error;;
let yytransl_const = [|
  258 (* OBRAC *);
  259 (* CBRAC *);
  260 (* OPARAN *);
  261 (* CPARAN *);
  262 (* COMMA *);
  263 (* SEMICOLON *);
  264 (* NEWLINE *);
  265 (* ASSIGN *);
  266 (* COLON *);
  267 (* ADD *);
  268 (* SUBT *);
  269 (* MULT *);
  270 (* DIV *);
  271 (* MAX *);
  272 (* MIN *);
  273 (* SUM *);
  274 (* AVG *);
  275 (* COUNT *);
  276 (* ROWCOUNT *);
  277 (* COLCOUNT *);
  278 (* ROWSUM *);
  279 (* COLSUM *);
  280 (* ROWAVG *);
  281 (* COLAVG *);
  282 (* ROWMIN *);
  283 (* COLMIN *);
  284 (* ROWMAX *);
  285 (* COLMAX *);
  286 (* EXCEPTION *);
    0|]

let yytransl_block = [|
  257 (* FLOAT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\005\000\
\003\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
\004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
\004\000\004\000\004\000\004\000\000\000"

let yylen = "\002\000\
\002\000\006\000\006\000\006\000\006\000\006\000\005\000\005\000\
\005\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\029\000\000\000\000\000\000\000\001\000\
\000\000\000\000\010\000\011\000\012\000\013\000\026\000\023\000\
\017\000\020\000\014\000\015\000\016\000\018\000\019\000\021\000\
\022\000\024\000\025\000\027\000\028\000\000\000\000\000\000\000\
\000\000\000\000\000\000\009\000\000\000\000\000\000\000\000\000\
\007\000\000\000\000\000\003\000\000\000\006\000\004\000\005\000\
\002\000\000\000\008\000"

let yydgoto = "\002\000\
\004\000\005\000\006\000\030\000\035\000"

let yysindex = "\024\000\
\031\255\000\000\034\255\000\000\028\255\029\255\033\255\000\000\
\245\254\036\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\026\255\037\255\038\255\
\031\255\038\255\019\255\000\000\039\255\035\255\040\255\041\255\
\000\000\042\255\043\255\000\000\031\255\000\000\000\000\000\000\
\000\000\046\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\245\255\000\000\253\255"

let yytablesize = 51
let yytable = "\011\000\
\012\000\013\000\014\000\015\000\016\000\017\000\018\000\019\000\
\020\000\021\000\022\000\023\000\024\000\025\000\026\000\027\000\
\028\000\029\000\034\000\040\000\003\000\038\000\033\000\042\000\
\001\000\041\000\032\000\003\000\037\000\033\000\039\000\043\000\
\003\000\050\000\007\000\008\000\031\000\009\000\010\000\036\000\
\000\000\033\000\000\000\000\000\045\000\044\000\046\000\047\000\
\048\000\049\000\051\000"

let yycheck = "\011\001\
\012\001\013\001\014\001\015\001\016\001\017\001\018\001\019\001\
\020\001\021\001\022\001\023\001\024\001\025\001\026\001\027\001\
\028\001\029\001\030\000\001\001\002\001\033\000\004\001\035\000\
\001\000\007\001\001\001\002\001\032\000\004\001\034\000\035\000\
\002\001\045\000\001\001\008\001\001\001\009\001\006\001\003\001\
\255\255\004\001\255\255\255\255\010\001\007\001\007\001\007\001\
\007\001\007\001\005\001"

let yynames_const = "\
  OBRAC\000\
  CBRAC\000\
  OPARAN\000\
  CPARAN\000\
  COMMA\000\
  SEMICOLON\000\
  NEWLINE\000\
  ASSIGN\000\
  COLON\000\
  ADD\000\
  SUBT\000\
  MULT\000\
  DIV\000\
  MAX\000\
  MIN\000\
  SUM\000\
  AVG\000\
  COUNT\000\
  ROWCOUNT\000\
  COLCOUNT\000\
  ROWSUM\000\
  COLSUM\000\
  ROWAVG\000\
  COLAVG\000\
  ROWMIN\000\
  COLMIN\000\
  ROWMAX\000\
  COLMAX\000\
  EXCEPTION\000\
  "

let yynames_block = "\
  FLOAT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'EXP) in
    Obj.repr(
# 7 "parser.mly"
                  (
            ""
      )
# 181 "parser.ml"
               : string))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'FUNC) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'RANGE) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 12 "parser.mly"
                                                 (

          )
# 193 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'FUNC) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : float) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 15 "parser.mly"
                                                 (

          )
# 205 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'FUNC) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'RANGE) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : float) in
    Obj.repr(
# 18 "parser.mly"
                                                 (

          )
# 217 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'FUNC) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'RANGE) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'INDEX) in
    Obj.repr(
# 21 "parser.mly"
                                                 (

          )
# 229 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'FUNC) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'INDEX) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 24 "parser.mly"
                                                 (

          )
# 241 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'FUNC) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 27 "parser.mly"
                                           (

          )
# 252 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'INDEX) in
    Obj.repr(
# 31 "parser.mly"
                                    (

     )
# 262 "parser.ml"
               : 'RANGE))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : float) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : float) in
    Obj.repr(
# 35 "parser.mly"
                                   (

     )
# 272 "parser.ml"
               : 'INDEX))
; (fun __caml_parser_env ->
    Obj.repr(
# 39 "parser.mly"
             (
               print_string("ADD function is called");
          )
# 280 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 42 "parser.mly"
              (
               print_string("SUBT function is called");
          )
# 288 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 45 "parser.mly"
              (
               print_string("MULT function is called");
          )
# 296 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 48 "parser.mly"
             (
               print_string("DIV function is called");
          )
# 304 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 51 "parser.mly"
               (
               print_string("COUNT function is called");
          )
# 312 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 54 "parser.mly"
                  (
               print_string("ROWCOUNT function is called");
          )
# 320 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 57 "parser.mly"
                  (
               print_string("COLCOUNT function is called");
          )
# 328 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 60 "parser.mly"
             (
               print_string("SUM function is called");
          )
# 336 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 63 "parser.mly"
                (
               print_string("ROWSUM function is called");
          )
# 344 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 66 "parser.mly"
                (
               print_string("COLSUM function is called");
          )
# 352 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 69 "parser.mly"
             (
               print_string("AVG function is called");
          )
# 360 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 72 "parser.mly"
                (
               print_string("ROWAVG function is called");
          )
# 368 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 75 "parser.mly"
                (
               print_string("COLAVG function is called");
          )
# 376 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 78 "parser.mly"
             (
               print_string("MIN function is called");
          )
# 384 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 81 "parser.mly"
                (
               print_string("ROWMIN function is called");
          )
# 392 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 84 "parser.mly"
                (
               print_string("COLMIN function is called");
          )
# 400 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 87 "parser.mly"
             (
               print_string("MAX function is called");
          )
# 408 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 90 "parser.mly"
                (
               print_string("ROWMAX function is called");
          )
# 416 "parser.ml"
               : 'FUNC))
; (fun __caml_parser_env ->
    Obj.repr(
# 93 "parser.mly"
                (
               print_string("COLMAX function is called");
          )
# 424 "parser.ml"
               : 'FUNC))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : string)
