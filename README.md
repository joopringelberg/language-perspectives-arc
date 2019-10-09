language-perspectives-arc
======================

This project provides very simple keyword coloring for the ARC syntax in Atom, using the [legacy textmate syntax](https://flight-manual.atom.io/hacking-atom/sections/creating-a-legacy-textmate-grammar/).

### Develop the grammar
This is the work cycle:

* change the file `perspectives-arc.coffee`
* in a shell, move to the project directory and run:

```
./node_modules/.bin/coffee src/perspectives-arc.coffee
```

* then reload Atom using `ctrl-alt-cmd-l`

### Useful references
* [oniguruma regex syntax](https://github.com/kkos/oniguruma/blob/master/doc/RE)
* [textmate selectors](https://macromates.com/manual/en/language_grammars)
* [Base16 Tomorrow Light Theme](https://github.com/atom/base16-tomorrow-light-theme). This is the theme I've taken the colors from.
* [A good guide to developing a grammar for Atom](https://gist.github.com/Aerijo/b8c82d647db783187804e86fa0a604a1#a-guide-to-writing-a-language-grammar-in-atom)

I gave up picking colors using the TextMate logic. Just look for a rule that has the color you want.
