dotfiles
========

It's dangerous to go alone. Take these.

This repository is a collection of dotfiles we use at
[space150](http://space150com). Much of it is copied from or inspired by
the work of the great folks at [thoughtbot](http://thoughtbot.com).

## Installing

```sh
# Clone this repo
cd
mkdir dotfiles
git clone git@github.com:space150/dotfiles dotfiles/space

# Install rcm
cd dotfiles/space
brew bundle

# Link the dotfiles
cd
env RCRC=$HOME/dotfiles/space/rcrc rcup -x README.md -x Brewfile
```

You can refer to the excellent docs thoughtbot has in [it's dotfiles
repo](https://github.com/thoughtbot/dotfiles) for more info.
