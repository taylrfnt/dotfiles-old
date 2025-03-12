{ config, pkgs, ... }:
{
  enable = true;
  lfs.enable = true;
  userName = "taylrfnt";
  userEmail = "taylr.fnt@gmail.com";
  signing.signByDefault = true;
  signing.key = "~/keys/ssh/github/amaterasu";
  extraConfig = {
    pull = {
      rebase = true;
    };
    init = {
      defaultBranch = "main";
    };
    diff = {
      tool = "vimdiff";
    };
    gpg = {
      format = "ssh";
    };
  };
}

