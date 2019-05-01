
example:
	make clean
	dune exec example/example.exe

top:
	dune build @install
	dune install orb
	dune build ppx/classic/ppx_orb_classic.exe
	utop -require orb -ppx _build/default/ppx/classic/ppx_orb_classic.exe  \
		-init ppx/classic/utop.ml

clean:
	dune clean

.PHONY: example top clean
