> [!IMPORTANT]
> This repo is now archived - I have moved to a flake-native management of my configurations that works across systems. 

# What is this Repository?
This repository is a one-stop-shop for all of my dotfiles (aka system configuration) for the various machines I use.
All of my system configurations are declarative, using [Nix](https://nixos.org/download/).

This allows for me to easily recreate my environment on a new machine with minimal effort, and offers me a declarative
solution for configuration that can be cross-referenced later.

# A Few Disclaimers
There is still a `.config` directory in this repository.  I have somewhat cheated the Nix implementation for two programs:
- Ghostty
- Neovim

For Ghostty, since the build is broken on Darwin systems (for a variety of reasons), you cannot directly implement Ghostty
configurations in Nix without a larger effort that frankly I do not wish to undertake.  My Neovim configuration is written
in Lua, and I still find myself changing it semi-regularly, so importing those config files makes the most sense for me currently.
I might migrate neovim to a fully-managed configuration in Nix someday once I settle down on a configuration I feel meets my needs.

# Using this repo's dotfiles
1. Check out this `dotfiles` repo in your `$HOME` directory using git:
```
mkdir -p ~/dotfiles && git clone ${REPO_URL} ~/dotfiles
```
2. Navigate into the freshly cloned directory:
```
cd ~/dotfiles
```
3. Run a nix system rebuild and switch to the desired flake:
**macOS**
```bash
nix run nix-darwin --extra-experimental-features "nix-command flakes" --switch --flake ~/dotfiles/nix/${HOST_ARCH}#${FLAKE_NAME}
```
**Linux**
```bash
tbd
```
