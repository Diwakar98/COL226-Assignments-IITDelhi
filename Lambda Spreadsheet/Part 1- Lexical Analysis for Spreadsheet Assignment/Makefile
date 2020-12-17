all:
	@ocamllex lexer.mll
	@ocamlopt -o lexer lexer.ml
	@./lexer < data.txt
