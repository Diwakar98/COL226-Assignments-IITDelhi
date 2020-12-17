(*  Diwakar Prajapati (2018CS10330)   *)
{
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
}
(* -,+ is an optional. The patern should be of a.b with no preceeding zeroes except in 0.a and no trailing zeroes*)

let float =    (['-''+']?['1'-'9']['0'-'9']*['.']['0'-'9']*['1'-'9'])                (* -/+ 203.012  *)
          |    (['-''+']?['0']['.']['0'-'9']*['1'-'9'])                              (* -/+ 0.013    *)
          |    (['-''+']?['1'-'9']['0'-'9']*['.']['0'])                              (* -/+ 201.0    *)
rule token = parse            (*Defining rules*)
          | float as i   {FLOAT (float_of_string i)}
          | [' ']        {SPACE}
          | ['(']        {OPARAN}
          | [')']        {CPARAN}
          | ['[']        {OBRAC}
          | [']']        {CBRAC}
          | [',']        {COMMA}
          | [';']        {SEMICOLON}
          | ['\n']       {NEWLINE}           (*Ignoring newlines*)
          | ":="         {ASSIGN}
          | [':']        {COLON}
          | "ADD"        {ADD}
          | "MULT"       {MULT}
          | "DIV"        {DIV}
          | "MAX"        {MAX}
          | "MIN"        {MIN}
          | "SUM"        {SUM}
          | "AVG"        {AVG}
          | "COUNT"      {COUNT}
          | "ROWCOUNT"   {ROWCOUNT}
          | "COLCOUNT"   {COLCOUNT}
          | "ROWSUM"     {ROWSUM}
          | "COLSUM"     {COLSUM}
          | "ROWAVG"     {ROWAVG}
          | "COLAVG"     {COLAVG}
          | "ROWMIN"     {ROWMIN}
          | "COLMIN"     {COLMIN}
          | "ROWMAX"     {ROWMAX}
          | "COLMAX"     {COLMAX}
          | _  {EXCEPTION}      (*Removing all foreign characters*)
          | eof {raise Eof}     (*Raising EOF exception in case if file ends, i.e. the lexer reaches the end of file*)
{
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
}
