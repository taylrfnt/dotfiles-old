{ config, pkgs, lib, ...}:

{
  enable = true;
  package = "${pkgs.oh-my-posh}";
  enableZshIntegration = true;
  settings = lib.importJSON ./zen.json; 
 }
