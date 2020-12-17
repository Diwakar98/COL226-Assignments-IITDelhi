open Lexer
open Parser
open Logic
let _ = begin
    (* try *)
          let lexbuf = Lexing.from_channel stdin in
          print_string "\nLoad the file by tying: [\'filename.pl\']\n\n";
          print_string "?- ";
          flush stdout;

          let filename = Parser.filename Lexer.token lexbuf in
          let input_channel = open_in filename in
          let lexbuf = Lexing.from_channel input_channel in
          let program = Parser.main_program Lexer.token lexbuf in
          print_string "true.\n";
          print_string "\n<----PROGRAM LOADED SUCCESSFULLY---->\n\n";
          flush stdout;
          (* print_program program;
          print_string "\n";
          flush stdout; *)

          let lexbuf = Lexing.from_channel stdin in
          while true do
               print_string "?- ";
               flush stdout;
               empty_result := true;
               result_firstline := true;
               let goals = Parser.main_goal Lexer.token lexbuf in
               print_newline();
               flush stdout;
               solve_program program goals;
               (*print_prbool u;*)
               print_newline();
               flush stdout;
          done
      end ;;