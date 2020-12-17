open Printf
open Lexing
open Backend
let _ =
    try
          let ic = open_in Sys.argv.(4) in
          let lexbuf = Lexing.from_channel ic in
           while true do

                let result = Parser.main Lexer.token lexbuf in
                print_newline();flush stdout
     done
    with Lexer.Eof ->
     print_string "\n";
      exit 0