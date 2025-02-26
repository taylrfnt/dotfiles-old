{ config, pkgs, lib, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  # let Home Manager install & manage itself
  programs.home-manager.enable = true;

  home = {
    username = "taylor";
    homeDirectory = "/Users/taylor";
    stateVersion = "24.11";
    packages = [];
  };

  xdg = {
    enable = true;
    configFile.nvim.source = mkOutOfStoreSymlink "/Users/taylor/dotfiles/.config/nvim";
  };

  programs = {
    # import our machine-specific modules first
    zsh = (import ../machines/amaterasu/zsh.nix { inherit config pkgs; });
    git = (import ../machines/amaterasu/git.nix { inherit config pkgs; });
    ## and our generic modules 
    oh-my-posh = (import ../home/oh-my-posh/oh-my-posh.nix { inherit config pkgs lib; });
    tmux = (import ../home/tmux.nix { inherit config pkgs; });
    neovim = (import ../home/neovim.nix { inherit config pkgs; });
    kitty = (import ../home/kitty.nix { inherit config pkgs; });
    k9s = (import ../home/k9s/k9s.nix { inherit config pkgs; });
    yt-dlp = (import ../home/yt-dlp.nix { inherit config pkgs; });
    alacritty = (import ../home/alacritty.nix { inherit config pkgs;} );
    ghostty = (import ../home/ghostty.nix { inherit config pkgs; });
  };
}

