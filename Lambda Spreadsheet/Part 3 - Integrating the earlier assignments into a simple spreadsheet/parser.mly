%{
     open Backend
%}
%token <float> FLOAT
%token <int> INT
%token OBRAC CBRAC OPARAN CPARAN COMMA SEMICOLON NEWLINE ASSIGN COLON ADD SUBT MULT DIV MAX MIN SUM AVG COUNT ROWCOUNT COLCOUNT ROWSUM COLSUM ROWAVG COLAVG ROWMIN COLMIN ROWMAX COLMAX EXCEPTION
%start main
%type <unit> main
%%
main:
          EXP NEWLINE {}
;
EXP:
     |     INDEX ASSIGN ROWCOUNT RANGE SEMICOLON{
                    testsheet := (row_count !testsheet $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN COLCOUNT RANGE SEMICOLON{
                    testsheet := (col_count !testsheet $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN ROWSUM RANGE SEMICOLON{
                    testsheet := (row_sum !testsheet $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN COLSUM RANGE SEMICOLON{
                    testsheet := (col_sum !testsheet $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN ROWAVG RANGE SEMICOLON{
                    testsheet := (row_avg !testsheet $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN COLAVG RANGE SEMICOLON{
                    testsheet := (col_avg !testsheet $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN ROWMIN RANGE SEMICOLON{
                    testsheet := (row_min !testsheet $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN COLMIN RANGE SEMICOLON{
                    testsheet := (col_min !testsheet $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN ROWMAX RANGE SEMICOLON{
                    testsheet := (row_max !testsheet $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN COLMAX RANGE SEMICOLON{
                    testsheet := (col_max !testsheet $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN COUNT RANGE SEMICOLON{
                    testsheet := (full_count !testsheet $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN SUM RANGE SEMICOLON{
                    testsheet := (full_sum !testsheet $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN AVG RANGE SEMICOLON{
                    testsheet := (full_avg !testsheet $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN MIN RANGE SEMICOLON{
                    testsheet := (full_min !testsheet $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN MAX RANGE SEMICOLON{
                    testsheet := (full_max !testsheet $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN ADD RANGE FLOAT SEMICOLON{
                    testsheet := (add_const !testsheet $4 $5 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN ADD FLOAT RANGE SEMICOLON{
                    testsheet := (add_const !testsheet $5 $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN ADD INDEX RANGE SEMICOLON{
                    if (get_from_sheet !testsheet $4 0.0) = Null then (testsheet := !testsheet)
                    else testsheet := (add_const !testsheet $5 (getvalue (get_from_sheet !testsheet $4 0.0)) $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN ADD RANGE INDEX SEMICOLON{
                    if (get_from_sheet !testsheet $5 0.0) = Null then (testsheet := !testsheet)
                    else testsheet := (add_const !testsheet $4 (getvalue (get_from_sheet !testsheet $5 0.0)) $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN ADD RANGE RANGE SEMICOLON{
                    testsheet :=  (add_range !testsheet $4 $5 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN SUBT RANGE FLOAT SEMICOLON{
                    testsheet :=  (subt_const !testsheet $4 $5 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN SUBT FLOAT RANGE SEMICOLON{
                    testsheet :=  (subt_const !testsheet $5 $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN SUBT INDEX RANGE SEMICOLON{
                    if (get_from_sheet !testsheet $4 0.0) = Null then (testsheet:=!testsheet)
                    else testsheet := (subt_const !testsheet $5 (getvalue (get_from_sheet !testsheet $4 0.0)) $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN SUBT RANGE INDEX SEMICOLON{
                    if (get_from_sheet !testsheet $5 0.0) = Null then (testsheet := !testsheet)
                    else testsheet :=  (subt_const !testsheet $4 (getvalue (get_from_sheet !testsheet $5 0.0)) $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN SUBT RANGE RANGE SEMICOLON{
                    testsheet := (subt_range !testsheet $4 $5 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN MULT RANGE FLOAT SEMICOLON{
                    testsheet :=  (mult_const !testsheet $4 $5 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN MULT FLOAT RANGE SEMICOLON{
                    testsheet :=  (mult_const !testsheet $5 $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN MULT INDEX RANGE SEMICOLON{
                    if (get_from_sheet !testsheet $4 0.0) = Null then (testsheet := !testsheet)
                    else testsheet :=  (mult_const !testsheet $5 (getvalue (get_from_sheet !testsheet $4 0.0)) $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN MULT RANGE INDEX SEMICOLON{
                    if (get_from_sheet !testsheet $5 0.0) = Null then (testsheet := !testsheet)
                    else testsheet :=  (mult_const !testsheet $4 (getvalue (get_from_sheet !testsheet $5 0.0)) $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN MULT RANGE RANGE SEMICOLON{
                    testsheet :=  (mult_range !testsheet $4 $5 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN DIV RANGE FLOAT SEMICOLON{
                    testsheet :=  (div_const !testsheet $4 $5 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN DIV FLOAT RANGE SEMICOLON{
                    testsheet :=  (div_const !testsheet $5 $4 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN DIV INDEX RANGE SEMICOLON{
                    if (get_from_sheet !testsheet $4 0.0) = Null then (testsheet := !testsheet)
                    else testsheet :=  (div_const !testsheet $5 (getvalue (get_from_sheet !testsheet $4 0.0)) $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN DIV RANGE INDEX SEMICOLON{
                    if (get_from_sheet !testsheet $5 0.0) = Null then (testsheet := !testsheet)
                    else testsheet :=  (div_const !testsheet $4 (getvalue (get_from_sheet !testsheet $5 0.0)) $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };
     |    INDEX ASSIGN DIV RANGE RANGE SEMICOLON{
                    testsheet := (div_range !testsheet $4 $5 $1);
                    print_sheet !testsheet;
                    print_string "----------------------------***----------------------------";
               };

RANGE:
     OPARAN INDEX COLON INDEX CPARAN{($2,$4)}
INDEX:
     OBRAC INT COMMA INT CBRAC {(float_of_int($2),float_of_int($4))}