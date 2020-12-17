ALL:
	@ocamllex lexer.mll
	@ocamlyacc parser.mly
	@ocamlc -c parser.mli
	@ocamlc -c lexer.ml
	@ocamlc -c parser.ml
	@ocamlc -c main.ml
	@ocamlc -o MAIN lexer.cmo parser.cmo main.cmo
	@mv lexer.ml ./others/lexer.ml
	@mv parser.ml ./others/parser.ml
	@mv parser.mli ./others/parser.mli
	@mv lexer.cmi ./obj/lexer.cmi
	@mv lexer.cmo ./obj/lexer.cmo
	@mv main.cmi ./obj/main.cmi
	@mv main.cmo ./obj/main.cmo
	@mv parser.cmi ./obj/parser.cmi
	@mv parser.cmo ./obj/parser.cmo
	@mv MAIN ./exe/MAIN
	@./exe/MAIN < input.txt