{ config, pkgs, ... }:
{
  enable = true;
  lfs.enable = true;
  userName = "taylrfnt";
  userEmail = "taylr.fnt@gmail.com";
  signing.key = "~/keys/github/amaterasu_ed25519";
  signing.signByDefault = true;

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
  };
}

