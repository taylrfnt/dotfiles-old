{ config, pkgs, ... }:
{
  enable = true;
  font = {
    name = "jetbrains-mono";
    package = "${pkgs.nerd-fonts.jetbrains-mono}";
    size = 16.0;
  };
  themeFile = "Catppuccin-Mocha";
  shellIntegration = {
    mode = "enabled";
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
  settings = {
    confirm_os_window_close = 0;
    macos_show_window_title_in = "none";
  };
  extraConfig = ''
    modify_font cell_height 120%
  '';
}

