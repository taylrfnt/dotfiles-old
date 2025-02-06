{ config, pkgs, ... }:

{
  nixpkgs = {
    hostPlatform = "aarch64-linux"; # The platform the configuration will be used on.
    config = {
      allowUnfree = true; # allow unfree app installs
    };
  };

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  nix = {
    ## Necessary for using flakes on this system.
    settings.experimental-features = "nix-command flakes";
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment = {
    systemPackages = [
      pkgs.zsh
      pkgs.oh-my-posh
      pkgs.zsh-vi-mode
      pkgs.zsh-autosuggestions
      pkgs.ncurses
      pkgs.neovim
      pkgs.tmux
      pkgs.git
      pkgs.stow
      pkgs.gh
      pkgs.pass
      pkgs.gnupg
      pkgs.raycast
      pkgs.maccy
      pkgs.bruno
      pkgs.openssh
      pkgs.yt-dlp
      pkgs.lua-language-server
      pkgs.gopls
      pkgs.marksman
      pkgs.gofumpt
      pkgs.prettierd
      pkgs.yaml-language-server
      pkgs.yamlfix
      pkgs.yamlfmt
      pkgs.shellcheck
      pkgs.uncrustify
      pkgs.bash-language-server
      pkgs.jq
      pkgs.stylua
      pkgs.kubectl
      pkgs.kitty
      pkgs.go
      pkgs.postgresql_17
      pkgs.sqls
      pkgs.sqlfluff
      pkgs.vesktop
      pkgs.utm
      pkgs.ghostty
    ];
    variables = {
      EDITOR = "nvim";
    };
  };

  # Install fonts
  fonts = {
    packages = [
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.commit-mono
    ];
  };

  # user setup
  users.users.taylor = {
    name = "taylor";
    description = "Taylor";
    home = "/Users/taylor";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "24.11";

}

