preface
===========
_**these are not conventional dotfiles.**_

these days i try to have as much configured through the [nix package manager](https://nixos.org) as possible.

if you're not using nix, you won't be able to use them in a simple fashion and would need to isolate the respective aspects.

---

## yet another opinionated minimalistic emacs

my emacs configuration is based around reducing the user interface down to basic elements without losing the kinds of
functionality you would expect to find in a modern editor such as vscode or sublime.

i've never been much of a fan of modelines because of the space they take up, and feebleline feels like the perfect solution 
to this. it migrates the core information displayed on a modeline into the echo area.
