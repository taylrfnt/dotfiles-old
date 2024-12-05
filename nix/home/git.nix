{ config, pkgs, ... }:
{
  enable = true;
  lfs.enable = true;
  userName = "taylrfnt";
  userEmail = "taylr.fnt@gmail.com";
  signing.key = "~/keys/github/gh_personal";
  signing.signByDefault = true;

  extraConfig = {
    pull = {
      rebase = true;
    };
    init = {
      defaultBranch = "main";
    };
  };
}

