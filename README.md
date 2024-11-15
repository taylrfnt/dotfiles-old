# dotfiles
This repository contains all of my dotfiles used to efficiently & repeatably customize an 
environment on any machine.

## Requirements
To use this repository to quickly configure a fresh OS/system, you need the following installed:
* [git](https://git-scm.com/)
* [GNU Stow](https://www.gnu.org/software/stow/)
* A package manager for your OS (`brew`, `pacman`, etc.)

### git
**MacOS**
```
brew install git
```
**Arch**
```
pacman -S git
```

### GNU Stow
**MacOS**
```
brew install stow
```
**Arch**
```
pacman -S stow
```

## Installation
1. Check out this `dotfiles` repo in your `$HOME` directory using git:
```
$ git clone git@github.com/taylrfnt/dotfiles.git
```
2. Navigate into the freshly cloned directory:
```
cd ~/dotfiles
```
3. Use GNU Stow to construct the symlink farm:
```
$ stow .
```

## References
Elliott at Dreams of Autonomy has a great video guide on using stow/dotfiles repo:\n
[Stow has forever changed the way I manage my dotfiles](https://www.youtube.com/watch?v=y6XCebnB9gs)
