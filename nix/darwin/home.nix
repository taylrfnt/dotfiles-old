{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  # let Home Manager install & manage itself
  programs.home-manager.enable = true;

  home = {
    username = "taylorfont";
    homeDirectory = "/Users/taylorfont";
    stateVersion = "24.11";
    packages = [
      pkgs.kubectl
    ];
  };

  xdg = {
    enable = true;
    configFile.nvim.source = mkOutOfStoreSymlink "/Users/taylorfont/dotfiles/.config/nvim";
  };

  programs = {
    tmux = (import ../home/tmux.nix { inherit config pkgs; });
    git = (import ../home/git.nix { inherit config pkgs; });
    neovim = (import ../home/neovim.nix { inherit config pkgs; });
    zsh = (import ../home/zsh.nix { inherit config pkgs; });
   # kitty = (import ../home/kitty.nix { inherit config pkgs; });
  };
}

