# dotfiles
This repository contains all of my dotfiles used to efficiently & repeatably customize an
environment on any machine.

## Requirements
To use this repository to quickly configure a fresh OS/system, you need the following installed:
* [git](https://git-scm.com/)
* [GNU Stow](https://www.gnu.org/software/stow/)
* A package manager for your OS to install the packages these dotfiles house configuration for (`nix`, `brew`, `pacman`, etc.)

### git
**macOS (homebrew)**
```
brew install git
```
**Arch**
```
pacman -S git
```

**NixOS (nix)**
```
environment.systemPackages =
        [ pkgs.git
          ...
        ];

```

### GNU Stow
**macOS**
```
brew install stow
```
**Arch**
```
pacman -S stow
```
**NixOS (nix)**
```
environment.systemPackages =
        [ pkgs.stow
          ...
        ];

```


## Packages & Apps
This repo contains custom configuration for the following apps/packages:
* alacritty
* kitty
* neofetch
* neovim
* ohmyposh
* tmux
* yt-dlp

The configuration files within can be installed with or without these apps/packages installed; however, it's
best to install them prior to any installation attempts to avoid any future headaches.

## Using this repo's dotfiles
1. Check out this `dotfiles` repo in your `$HOME` directory using git:
```
$ git clone git@github.com/taylrfnt/dotfiles.git ~
```
2. Navigate into the freshly cloned directory:
```
cd ~/dotfiles
```
3. If you wish to remove certain configurations, do so now, otherwise they will be symlinked and more difficult to remove.
4. Use GNU Stow to construct the symlink farm:
```
$ stow --adopt .
```

## References
Elliott at Dreams of Autonomy has a great video guide on using stow/dotfiles repo:
* [Stow has forever changed the way I manage my dotfiles](https://www.youtube.com/watch?v=y6XCebnB9gs)

