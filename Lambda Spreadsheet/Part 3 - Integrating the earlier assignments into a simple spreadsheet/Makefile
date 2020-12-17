ALL:
	@ocamlc -c backend.ml
	@ocamllex lexer.mll
	@ocamlyacc parser.mly
	@ocamlc -c parser.mli
	@ocamlc -c lexer.ml
	@ocamlc -c parser.ml
	@ocamlc -c main.ml
	@ocamlc -o MAIN str.cma backend.cmo lexer.cmo parser.cmo main.cmo
	@mv lexer.ml ./others/lexer.ml
	@mv parser.ml ./others/parser.ml
	@mv parser.mli ./others/parser.mli
	@mv lexer.cmi ./others/lexer.cmi
	@mv lexer.cmo ./obj/lexer.cmo
	@mv main.cmi ./others/main.cmi
	@mv main.cmo ./obj/main.cmo
	@mv parser.cmi ./others/parser.cmi
	@mv parser.cmo ./obj/parser.cmo
	@mv backend.cmo ./obj/backend.cmo
	@mv backend.cmi ./obj/backend.cmi
	@mv MAIN ./exe/MAIN