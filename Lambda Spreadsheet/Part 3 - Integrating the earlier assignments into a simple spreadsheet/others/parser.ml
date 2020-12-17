type token =
  | FLOAT of (float)
  | INT of (int)
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
# 2 "parser.mly"
     open Backend
# 39 "parser.ml"
let yytransl_const = [|
  259 (* OBRAC *);
  260 (* CBRAC *);
  261 (* OPARAN *);
  262 (* CPARAN *);
  263 (* COMMA *);
  264 (* SEMICOLON *);
  265 (* NEWLINE *);
  266 (* ASSIGN *);
  267 (* COLON *);
  268 (* ADD *);
  269 (* SUBT *);
  270 (* MULT *);
  271 (* DIV *);
  272 (* MAX *);
  273 (* MIN *);
  274 (* SUM *);
  275 (* AVG *);
  276 (* COUNT *);
  277 (* ROWCOUNT *);
  278 (* COLCOUNT *);
  279 (* ROWSUM *);
  280 (* COLSUM *);
  281 (* ROWAVG *);
  282 (* COLAVG *);
  283 (* ROWMIN *);
  284 (* COLMIN *);
  285 (* ROWMAX *);
  286 (* COLMAX *);
  287 (* EXCEPTION *);
    0|]

let yytransl_block = [|
  257 (* FLOAT *);
  258 (* INT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\004\000\003\000\000\000"

let yylen = "\002\000\
\002\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
\005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
\006\000\006\000\006\000\006\000\006\000\006\000\006\000\006\000\
\006\000\006\000\006\000\006\000\006\000\006\000\006\000\006\000\
\006\000\006\000\006\000\006\000\005\000\005\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\039\000\000\000\000\000\000\000\001\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\038\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\016\000\015\000\013\000\014\000\012\000\002\000\003\000\004\000\
\005\000\006\000\007\000\008\000\009\000\010\000\011\000\018\000\
\000\000\019\000\017\000\020\000\021\000\023\000\024\000\022\000\
\025\000\026\000\028\000\029\000\027\000\030\000\031\000\033\000\
\034\000\032\000\035\000\036\000\000\000\037\000"

let yydgoto = "\002\000\
\004\000\005\000\006\000\034\000"

let yysindex = "\016\000\
\016\255\000\000\020\255\000\000\018\255\014\255\021\255\000\000\
\053\255\023\255\003\255\004\255\009\255\010\255\025\255\025\255\
\025\255\025\255\025\255\025\255\025\255\025\255\025\255\025\255\
\025\255\025\255\025\255\025\255\025\255\027\255\025\255\016\255\
\025\255\015\255\025\255\025\255\084\255\025\255\025\255\087\255\
\025\255\025\255\090\255\043\255\045\255\076\255\086\255\088\255\
\089\255\091\255\092\255\093\255\094\255\095\255\096\255\097\255\
\098\255\099\255\000\000\100\255\101\255\102\255\103\255\105\255\
\106\255\107\255\108\255\109\255\110\255\111\255\112\255\113\255\
\114\255\115\255\116\255\117\255\118\255\119\255\120\255\121\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\016\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\124\255\000\000"

let yyrindex = "\000\000\
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
\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\245\255\021\000"

let yytablesize = 130
let yytable = "\033\000\
\036\000\039\000\042\000\031\000\035\000\003\000\003\000\032\000\
\032\000\038\000\041\000\003\000\003\000\032\000\032\000\063\000\
\001\000\003\000\003\000\032\000\061\000\007\000\064\000\009\000\
\030\000\069\000\008\000\010\000\074\000\032\000\059\000\079\000\
\037\000\040\000\043\000\044\000\045\000\046\000\047\000\048\000\
\049\000\050\000\051\000\052\000\053\000\054\000\055\000\056\000\
\057\000\058\000\081\000\060\000\082\000\062\000\065\000\066\000\
\067\000\070\000\071\000\072\000\075\000\076\000\077\000\080\000\
\011\000\012\000\013\000\014\000\015\000\016\000\017\000\018\000\
\019\000\020\000\021\000\022\000\023\000\024\000\025\000\026\000\
\027\000\028\000\029\000\083\000\068\000\117\000\003\000\073\000\
\032\000\003\000\078\000\032\000\003\000\084\000\032\000\085\000\
\086\000\000\000\087\000\088\000\089\000\090\000\091\000\092\000\
\093\000\094\000\095\000\096\000\000\000\098\000\099\000\097\000\
\100\000\101\000\102\000\103\000\104\000\105\000\106\000\107\000\
\108\000\109\000\110\000\111\000\112\000\113\000\114\000\115\000\
\116\000\118\000"

let yycheck = "\011\000\
\012\000\013\000\014\000\001\001\001\001\003\001\003\001\005\001\
\005\001\001\001\001\001\003\001\003\001\005\001\005\001\001\001\
\001\000\003\001\003\001\005\001\032\000\002\001\034\000\010\001\
\002\001\037\000\009\001\007\001\040\000\005\001\004\001\043\000\
\012\000\013\000\014\000\015\000\016\000\017\000\018\000\019\000\
\020\000\021\000\022\000\023\000\024\000\025\000\026\000\027\000\
\028\000\029\000\008\001\031\000\008\001\033\000\034\000\035\000\
\036\000\037\000\038\000\039\000\040\000\041\000\042\000\043\000\
\012\001\013\001\014\001\015\001\016\001\017\001\018\001\019\001\
\020\001\021\001\022\001\023\001\024\001\025\001\026\001\027\001\
\028\001\029\001\030\001\008\001\001\001\097\000\003\001\001\001\
\005\001\003\001\001\001\005\001\003\001\008\001\005\001\008\001\
\008\001\255\255\008\001\008\001\008\001\008\001\008\001\008\001\
\008\001\008\001\008\001\008\001\255\255\008\001\008\001\011\001\
\008\001\008\001\008\001\008\001\008\001\008\001\008\001\008\001\
\008\001\008\001\008\001\008\001\008\001\008\001\008\001\008\001\
\008\001\006\001"

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
  INT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'EXP) in
    Obj.repr(
# 11 "parser.mly"
                      ()
# 231 "parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 14 "parser.mly"
                                                (
                    testsheet := (row_count !testsheet _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 243 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 19 "parser.mly"
                                               (
                    testsheet := (col_count !testsheet _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 255 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 24 "parser.mly"
                                             (
                    testsheet := (row_sum !testsheet _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 267 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 29 "parser.mly"
                                             (
                    testsheet := (col_sum !testsheet _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 279 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 34 "parser.mly"
                                             (
                    testsheet := (row_avg !testsheet _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 291 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 39 "parser.mly"
                                             (
                    testsheet := (col_avg !testsheet _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 303 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 44 "parser.mly"
                                             (
                    testsheet := (row_min !testsheet _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 315 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 49 "parser.mly"
                                             (
                    testsheet := (col_min !testsheet _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 327 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 54 "parser.mly"
                                             (
                    testsheet := (row_max !testsheet _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 339 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 59 "parser.mly"
                                             (
                    testsheet := (col_max !testsheet _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 351 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 64 "parser.mly"
                                            (
                    testsheet := (full_count !testsheet _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 363 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 69 "parser.mly"
                                          (
                    testsheet := (full_sum !testsheet _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 375 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 74 "parser.mly"
                                          (
                    testsheet := (full_avg !testsheet _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 387 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 79 "parser.mly"
                                          (
                    testsheet := (full_min !testsheet _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 399 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 84 "parser.mly"
                                          (
                    testsheet := (full_max !testsheet _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 411 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'RANGE) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : float) in
    Obj.repr(
# 89 "parser.mly"
                                                (
                    testsheet := (add_const !testsheet _4 _5 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 424 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : float) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 94 "parser.mly"
                                                (
                    testsheet := (add_const !testsheet _5 _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 437 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'INDEX) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 99 "parser.mly"
                                                (
                    if (get_from_sheet !testsheet _4 0.0) = Null then (testsheet := !testsheet)
                    else testsheet := (add_const !testsheet _5 (getvalue (get_from_sheet !testsheet _4 0.0)) _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 451 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'RANGE) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'INDEX) in
    Obj.repr(
# 105 "parser.mly"
                                                (
                    if (get_from_sheet !testsheet _5 0.0) = Null then (testsheet := !testsheet)
                    else testsheet := (add_const !testsheet _4 (getvalue (get_from_sheet !testsheet _5 0.0)) _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 465 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'RANGE) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 111 "parser.mly"
                                                (
                    testsheet :=  (add_range !testsheet _4 _5 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 478 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'RANGE) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : float) in
    Obj.repr(
# 116 "parser.mly"
                                                 (
                    testsheet :=  (subt_const !testsheet _4 _5 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 491 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : float) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 121 "parser.mly"
                                                 (
                    testsheet :=  (subt_const !testsheet _5 _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 504 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'INDEX) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 126 "parser.mly"
                                                 (
                    if (get_from_sheet !testsheet _4 0.0) = Null then (testsheet:=!testsheet)
                    else testsheet := (subt_const !testsheet _5 (getvalue (get_from_sheet !testsheet _4 0.0)) _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 518 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'RANGE) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'INDEX) in
    Obj.repr(
# 132 "parser.mly"
                                                 (
                    if (get_from_sheet !testsheet _5 0.0) = Null then (testsheet := !testsheet)
                    else testsheet :=  (subt_const !testsheet _4 (getvalue (get_from_sheet !testsheet _5 0.0)) _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 532 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'RANGE) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 138 "parser.mly"
                                                 (
                    testsheet := (subt_range !testsheet _4 _5 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 545 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'RANGE) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : float) in
    Obj.repr(
# 143 "parser.mly"
                                                 (
                    testsheet :=  (mult_const !testsheet _4 _5 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 558 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : float) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 148 "parser.mly"
                                                 (
                    testsheet :=  (mult_const !testsheet _5 _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 571 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'INDEX) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 153 "parser.mly"
                                                 (
                    if (get_from_sheet !testsheet _4 0.0) = Null then (testsheet := !testsheet)
                    else testsheet :=  (mult_const !testsheet _5 (getvalue (get_from_sheet !testsheet _4 0.0)) _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 585 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'RANGE) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'INDEX) in
    Obj.repr(
# 159 "parser.mly"
                                                 (
                    if (get_from_sheet !testsheet _5 0.0) = Null then (testsheet := !testsheet)
                    else testsheet :=  (mult_const !testsheet _4 (getvalue (get_from_sheet !testsheet _5 0.0)) _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 599 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'RANGE) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 165 "parser.mly"
                                                 (
                    testsheet :=  (mult_range !testsheet _4 _5 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 612 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'RANGE) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : float) in
    Obj.repr(
# 170 "parser.mly"
                                                (
                    testsheet :=  (div_const !testsheet _4 _5 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 625 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : float) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 175 "parser.mly"
                                                (
                    testsheet :=  (div_const !testsheet _5 _4 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 638 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'INDEX) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 180 "parser.mly"
                                                (
                    if (get_from_sheet !testsheet _4 0.0) = Null then (testsheet := !testsheet)
                    else testsheet :=  (div_const !testsheet _5 (getvalue (get_from_sheet !testsheet _4 0.0)) _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 652 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'RANGE) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'INDEX) in
    Obj.repr(
# 186 "parser.mly"
                                                (
                    if (get_from_sheet !testsheet _5 0.0) = Null then (testsheet := !testsheet)
                    else testsheet :=  (div_const !testsheet _4 (getvalue (get_from_sheet !testsheet _5 0.0)) _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 666 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'RANGE) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'RANGE) in
    Obj.repr(
# 192 "parser.mly"
                                                (
                    testsheet := (div_range !testsheet _4 _5 _1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               )
# 679 "parser.ml"
               : 'EXP))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'INDEX) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'INDEX) in
    Obj.repr(
# 199 "parser.mly"
                                    ((_2,_4))
# 687 "parser.ml"
               : 'RANGE))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : int) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : int) in
    Obj.repr(
# 201 "parser.mly"
                               ((float_of_int(_2),float_of_int(_4)))
# 695 "parser.ml"
               : 'INDEX))
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : unit)
