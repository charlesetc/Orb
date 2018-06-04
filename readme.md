
# Orb

Orb does some crazy stuff...

Basically Orb is a collection of libraries, and then an ast mapper (ppx)
that rewrites normal OCaml literals to use Orb's types. And then some more
functions for fun...

So for example, this is all valid orb:

```
puts ^ 2 + 2 ;
puts ^ 2.3 + 5.6 ;
puts ^ "hi " + "you" ;
```

Uhh...

Did you just change what integers and strings do? **yep**

Did you just change the `^` operator? **you bet**

Did you make everything an object? **I did**

I think that OCaml's standard library does some things very badly, for
example `print_endline` should work on all data.

So at its best Orb is an attempt to make a usable alternative standard
library. Is it usable now? *No*.

At its least, Orb showcases how useful Ppx is, and just how configurable
OCaml is.

See [example/example.ml](example/example.ml) for more weirdness!
Want a repl? Just `make top`
