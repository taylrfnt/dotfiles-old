{ config, pkgs, ... }:
{
  enable = true;
  font = {
    name = "jetbrains-mono";
    package = "pkgs.nerd-fonts";
    size = 16.0;
  };
  themeFile = "Catppuccin-Mocha";
}

