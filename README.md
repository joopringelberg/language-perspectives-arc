# language-perspectives-arc

This is the README for the language extension "perspectives-arc" in atom. To benefit from syntax coloring in vscode while editing a perspectives model (written in the ARC language), you need to add two extensions to your atom environment:

* a language extension for the Perspectives ARC language (provided in this repo);
* a theme that complements the language extension (see the repo [theme-perspectives-arc](https://github.com/joopringelberg/theme-perspectives-arc.git); the theme extension may be downloaded there).

The code in this package follows the language extension as developed for vscode. Please refer to that repo for more information on implementation choices.

## Getting and installing it
Use the Atom Package Manager to download this package from Github to your installation. `apm` is bundled and installed automatically with Atom. You can run the Atom > Install Shell Commands menu option to install it again if you aren't able to run it from a terminal (macOS only).

To install the latest version, run on the command line (location doesn't matter):

```
apm install https://github.com/joopringelberg/language-perspectives-arc.git
```

Sadly, `apm` does not support installing a particular version. Also, it actually clones the package include with the git revision history, which you don't need and just uses disk space.

As an alternative, download the package directly into the packages directory of Atom. Find the location of community packages by evaluating on the command line;

```
apm list
```
and copy the location behind the branch Community Packages (on Mac Osx it would be `~/.atom/packages`).

Then download a particular tagged version from Github (open the repo, click on Releases on the left, move to the desired tag, open it and copy the `language-perspectives-arc-X.Y.Z.zip` file). Move the file into the location you've found above and unzip it (remember to remove an older version first!).


## Uninstalling it
Uninstalling a package in Atom is easy. Open Atom settings, move to the packages tab, select the package and click `Uninstall`.


## Example files
A model file example can be found in the `arc sources` directory.

## Release Notes

### 0.0.2
The first version used for testing installation.

### 0.0.2
Release (chosen to be on par with the vscode version of the tokenizer).


## Requirements

There are no extra requirements.

## Extension Settings

This language extension as no specific settings.

## Known Issues

* Make comments effective and disable other rules within comments.
* Keywords view, aspect, use, filledBy and indexed.



This project provides very simple keyword coloring for the ARC syntax in Atom, using the [legacy textmate syntax](https://flight-manual.atom.io/hacking-atom/sections/creating-a-legacy-textmate-grammar/).

### Develop the grammar
Don't work on the grammar in this package; instead, work in the package for vscode and copy the contents of the `arc.tmLanguage.json` file into the `perspectives-arc.json` file in `grammars`.

### Useful references
* [oniguruma regex syntax](https://github.com/kkos/oniguruma/blob/master/doc/RE)
* [textmate selectors](https://macromates.com/manual/en/language_grammars)
* [A good guide to developing a grammar for Atom](https://gist.github.com/Aerijo/b8c82d647db783187804e86fa0a604a1#a-guide-to-writing-a-language-grammar-in-atom)

## Package for distribution
There is no separate packaging step for Atom extensions. The repo as such is copied into an Atom installation (see the steps above).

## Releasing
* set the new version number in the package file.
* push all changes to github.
* create a new tag, use the semantic version number preceded by 'v', e.g. `v0.1.0`. FOLLOW THE vscode VERSIONS!
* push the tag on the command line (vscode won't do it):

```
git push origin <tagname>
```
