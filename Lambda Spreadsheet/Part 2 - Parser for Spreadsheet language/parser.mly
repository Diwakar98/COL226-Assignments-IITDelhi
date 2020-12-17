%token <float> FLOAT
%token OBRAC CBRAC OPARAN CPARAN COMMA SEMICOLON NEWLINE ASSIGN COLON ADD SUBT MULT DIV MAX MIN SUM AVG COUNT ROWCOUNT COLCOUNT ROWSUM COLSUM ROWAVG COLAVG ROWMIN COLMIN ROWMAX COLMAX EXCEPTION
%start main             /* the entry point */
%type <string> main
%%
main:
      EXP NEWLINE {
            ""
      }
;
EXP:
          INDEX ASSIGN FUNC RANGE RANGE SEMICOLON{

          }
     |    INDEX ASSIGN FUNC FLOAT RANGE SEMICOLON{

          }
     |    INDEX ASSIGN FUNC RANGE FLOAT SEMICOLON{

          }
     |    INDEX ASSIGN FUNC RANGE INDEX SEMICOLON{

          }
     |    INDEX ASSIGN FUNC INDEX RANGE SEMICOLON{

          }
     |    INDEX ASSIGN FUNC RANGE SEMICOLON{

          }
RANGE:
     OPARAN INDEX COLON INDEX CPARAN{

     }
INDEX:
     OBRAC FLOAT COMMA FLOAT CBRAC {

     }
FUNC:
          ADD{
               print_string("ADD function is called");
          }
     |    SUBT{
               print_string("SUBT function is called");
          }
     |    MULT{
               print_string("MULT function is called");
          }
     |    DIV{
               print_string("DIV function is called");
          }
     |    COUNT{
               print_string("COUNT function is called");
          }
     |    ROWCOUNT{
               print_string("ROWCOUNT function is called");
          }
     |    COLCOUNT{
               print_string("COLCOUNT function is called");
          }
     |    SUM{
               print_string("SUM function is called");
          }
     |    ROWSUM{
               print_string("ROWSUM function is called");
          }
     |    COLSUM{
               print_string("COLSUM function is called");
          }
     |    AVG{
               print_string("AVG function is called");
          }
     |    ROWAVG{
               print_string("ROWAVG function is called");
          }
     |    COLAVG{
               print_string("COLAVG function is called");
          }
     |    MIN{
               print_string("MIN function is called");
          }
     |    ROWMIN{
               print_string("ROWMIN function is called");
          }
     |    COLMIN{
               print_string("COLMIN function is called");
          }
     |    MAX{
               print_string("MAX function is called");
          }
     |    ROWMAX{
               print_string("ROWMAX function is called");
          }
     |    COLMAX{
               print_string("COLMAX function is called");
          }