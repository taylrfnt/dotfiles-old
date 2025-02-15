{ config, pkgs, ... }:
#{ config, pkgs, pkgs-master, ... }:

{
  nixpkgs = {
    hostPlatform = "aarch64-darwin"; # The platform the configuration will be used on.
    config = {
      allowUnfree = true; # allow unfree app installs
    };
  };

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  nix = {
    # Allow building and running binaries for x86_64 and aarch64 (enabled by Rosetta 2)
    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
    ## Linux builder provided by NixOS VM that works on Apple Silicon & Intel Macs
    # linux-builder.enable = true;
    ## Necessary for using flakes on this system.
    settings.experimental-features = "nix-command flakes";
  };
  
  # Removed in latest nix-darwin upgrade (nix.enable = true as default)
  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;

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
      pkgs.mkalias # nix needs to make darwin aliases rather than symlinks for apps
      pkgs.openssh
      pkgs.yt-dlp
      pkgs.uncrustify
      pkgs.kubectl
      pkgs.k9s
      pkgs.kitty
      pkgs.go
      pkgs.postgresql_17
      pkgs.vesktop
      pkgs.utm
      pkgs.tree-sitter
      pkgs.nixd
      pkgs.deadnix
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

  # source homebrew
  # Configure Homebrew
  homebrew = {
    enable = true;
    casks = [
      "firefox@nightly"
      "google-chrome"
      "iina"
      "the-unarchiver"
      "bitwarden"
      "thunderbird"
      "obsidian"
      # "ghostty"
      # make ghostty greedy since we use tip instead of main/stable
      {
        name = "ghostty@tip";
        greedy = true;
      }
      "lulu"
      "oversight"
      "keycastr"
      "obs"
      "audio-hijack"
      "steam"
      "deskpad"
     ];

    brews = [
      "mas" # needs xcode-select (TODO: find automated install)
      "coreutils"
      "helm"
      "helmfile"
      "telnet"
      "sequin"
      "asciinema"
      "openjdk@17"
      "node@23"
      "ripgrep"
      "zig"
    ];

    masApps = {
      "Yoink" = 457622435;
      "Pages" = 409201541;
      "Numbers" = 409203825;
      "Keynote" = 409183694;
      "Parcel" = 639968404;
      "Xcode" = 497799835;
    };

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

  # user setup
  users.users.taylor = {
    name = "taylor";
    description = "Taylor";
    home = "/Users/taylor";
  };

  # login items
  launchd.user.agents = {

    raycast = {
      serviceConfig.ProgramArguments =
        [ "${pkgs.raycast}/Applications/Raycast.app/Contents/MacOS/Raycast" ];
        # [ "${pkgs-master.raycast}/Applications/Raycast.app/Contents/MacOS/Raycast" ];
      serviceConfig.RunAtLoad = true;
    };

    maccy = {
      serviceConfig.ProgramArguments =
        [ "${pkgs.maccy}/Applications/Maccy.app/Contents/MacOS/Maccy" ];
      serviceConfig.RunAtLoad = true;
    };

    oversight = {
      serviceConfig.ProgramArguments =
        [ "/Applications/OverSight.app/Contents/MacOS/OverSight" ];
      serviceConfig.RunAtLoad = true;
    };

    lulu = {
      serviceConfig.ProgramArguments =
        [ "/Applications/LuLu.app/Contents/MacOS/LuLu" ];
      serviceConfig.RunAtLoad = true;
    };

    yoink = {
      serviceConfig.ProgramArguments =
        [ "/Applications/Yoink.app/Contents/MacOS/Yoink" ];
      serviceConfig.RunAtLoad = true;
    };

  };

  system = {

    activationScripts = {
      # using MacOs aliases instead of symlinks to allow apps to be indexed by spotlight
      applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';
      # automatically catch (most) new prefs without login/restart
      postUserActivation.text = ''
        /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      '';
    };

    #MacOS system configuration
    defaults = {
      ".GlobalPreferences"."com.apple.sound.beep.sound" = "/System/Library/Sounds/Blow.aiff";
      dock = {
        autohide = true;
        autohide-delay = 0.0; # no delay for auto-hide/show
        orientation = "bottom";
        mineffect = "scale";
        minimize-to-application = true;
        magnification = false;
        show-recents = false; # hide recent apps from dock
        persistent-apps = [
          "/System/Applications/Launchpad.app"
          "/Applications/Firefox Nightly.app"
          "/Applications/Google Chrome.app/"
          "/Applications/Bitwarden.app"
          "/System/Applications/Messages.app"
          "/System/Applications/FaceTime.app"
          "/Applications/Thunderbird.app"
          "/System/Applications/Photos.app"
          "/System/Applications/TV.app"
          "/System/Applications/Music.app"
          "/System/Applications/News.app"
          "/Applications/Nix Apps/Vesktop.app"
          "/Applications/Obsidian.app/"
          "/Applications/IINA.app/"
          "/Applications/Ghostty.app"
          "/System/Applications/App Store.app"
          "/System/Applications/System Settings.app"
          "/System/Applications/iPhone Mirroring.app"
        ];
        persistent-others = [
          "/Users/taylor/Downloads"
        ];
      };

      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "clmv";
        _FXSortFoldersFirst = true;
      };

      loginwindow = {
        GuestEnabled = false;
        LoginwindowText= " ";
        SHOWFULLNAME = false;
      };

      menuExtraClock = {
        Show24Hour = true;
        ShowSeconds = true;
      };

      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleInterfaceStyle = "Dark";
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticInlinePredictionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSWindowShouldDragOnGesture = true;
      };

      screencapture = {
        type = "png";
        target = "clipboard";
      };
    };
    # Set Git commit hash for darwin-version.
    # configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;
  };

}

