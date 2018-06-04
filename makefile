
example:
	jbuilder exec example/example.exe

top:
	jbuilder build @install
	jbuilder install orb
	jbuilder build ppx/classic/ppx_orb_classic.exe
	utop -require orb -ppx _build/default/ppx/classic/ppx_orb_classic.exe  \
		-init ppx/classic/utop.ml

clean:
	jbuilder clean

.PHONY: example top clean
