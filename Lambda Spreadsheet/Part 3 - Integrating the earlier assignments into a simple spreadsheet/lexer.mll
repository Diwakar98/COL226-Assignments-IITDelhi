{
        open Parser        (* The type token is defined in parser.mli *)
        open Backend
        exception Eof
}
let float =    (['-''+']?['1'-'9']['0'-'9']*['.']['0'-'9']*['1'-'9'])
          |    (['-''+']?['0']['.']['0'-'9']*['1'-'9'])
          |    (['-''+']?['1'-'9']['0'-'9']*['.']['0'])
          |    ['0']['.']['0']

let int = (['-''+']?['1'-'9']['0'-'9']*) | (['0'])

rule token = parse            (*Defining rules*)
          | float as i   {FLOAT (float_of_string i)}
          | int as i     {INT (int_of_string i)}
          | [' ' '\t']   {token lexbuf}
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
          | "SUBT"       {SUBT}
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
          | eof {raise Eof}
