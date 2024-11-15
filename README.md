# dotfiles
This repository contains all of my dotfiles used to efficiently & repeatably customize an 
environment on any machine.

## Requirements
To use this repository to quickly configure a fresh OS/system, you need the following installed:
* [git](https://git-scm.com/)
* [GNU Stow](https://www.gnu.org/software/stow/)
* A package manager for your OS (`nix`, `brew`, `pacman`, etc.)

### A word on Nix 
If you are using Nix as yopur package manager, the installation will differ due to the declarative
nature of Nix/NixOS. Refer to the Nix section for instructions on using this repo to configure a 
fresh environment with Nix as your package manager.

### git
**macOS**
```
brew install git
```
**Arch**
```
pacman -S git
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

## Nix setup
If you are using the Nix package manager, you will need to follow a different installation procedure
for the required packages to leverage this repo's contents.

### darwin (macOS)
A Nix config for darwin systems is also in this repo, so setting up a clean
macOS environment via Nix can be run with the following:
1. Install Nix package manager ([taken from the Nix official site](https://nixos.org/download/)):
```
$ sh <(curl -L https://nixos.org/nix/install)
```
* You may need to agree/confirm to several prompts during the installation.
2. Test your install:
```
$ nix-shell -p neofetch --run neofetch
```
3. Run `nix` to apply the configurations defined in this repo:
```
$ nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles/nix#{CONFIGURATION_NAME}
```
4. Verify `nix-darwin` install/configuration:
```
$ which nix-darwin
```
5. If you make any further changes, you can apply the changes by running the following command:
```
darwin-rebuild switch
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
### Nix on darwin
Elliott at Dreams of Autonomy's guide for nix-darwin is essential:
* [Nix is my favorite package manager to use on macOS](https://www.youtube.com/watch?v=Z8BL8mdzWHI)
Elliott at Dreams of Autonomy has a great video guide on using stow/dotfiles repo:
* [Stow has forever changed the way I manage my dotfiles](https://www.youtube.com/watch?v=y6XCebnB9gs)
