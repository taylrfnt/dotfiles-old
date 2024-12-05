{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  programs.home-manager.enable = true;

  home.username = "taylorfont";
  home.homeDirectory = "/Users/taylorfont";
  xdg.enable = true;

  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/Users/taylorfont/dotfiles/.config/nvim";

  home.stateVersion = "24.11";

  programs = {
    tmux = (import ../home/tmux.nix { inherit pkgs; });
  };
}

