
# Orb

Orb does some pretty weird stuff...

Basically Orb is a collection of libraries, and then an ast mapper (ppx)
that rewrites normal OCaml literals to use Orb's types. And then some more
functions for fun...

So for example, this is a valid, complete, orb program:

```
puts ^ 2 + 2 ;
puts ^ 2.3 + 5.6 ;
puts ^ "hi " + "you" ;
puts {var = 23}.var
```

Uhh...

Did you just change what integers and strings do? **yep**

Did you just change the `^` operator? **you bet**

Did you make everything an object? **I did**

I love OCaml: even the object system! Orb doesn't mess around with
inheritance but takes full advantage of the row polymorphism
presented by the object system and polymorphic variants in OCaml.

So at its best Orb is an attempt to make a usable alternative standard
library. Is it usable now? *No*.

At its least, Orb showcases how useful Ppx is, and just how configurable
OCaml is.

See [example/example.ml](example/example.ml) for more weirdness!
Want a repl? Just `make top`
