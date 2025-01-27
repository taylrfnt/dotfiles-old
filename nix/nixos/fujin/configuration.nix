# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{

  nixpkgs = {
    hostPlatform = "aarch64-darwin"; # The platform the configuration will be used on.
    config = {
      allowUnfree = true; # allow unfree app installs
    };
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "fujin"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    #useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.taylor = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    # Created using mkpasswd
    hashedPassword = "$6$QHI78ky1rOZZkAOh$FCRwbkcpLynrwzuQ1shI6q5s3xav7ipfp4voxWxNZM7SKR5ga7RWhcmWPpFfb0jmTXObd39mvG9I.h4n3XJZx1";
    # openssh.authorizedKeys.keys = [];
    shell = ${pkgs.zsh}
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     neovim
     cifs-utils
     nfs-utils
     git
     dig
     stow
     pass
     ghostty
     zsh
     go
     postgresql_16
     zsh-vi-mode
     zsh-autosuggestions
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.banner = ''
                         .s.s.
                      , `'`Y8bso.
                    ,d88bso y'd8l
                    "`,8K j8P?*?b.
                   ,bonsai_`o.o
              ,r.osbJ--','  e8b?Y..
             j*Y888P*{ `._.-'" 888b
               `"'``,.`'-. `"*?*P"
                db8sld-'., ,):5ls.
           <sd88P,-d888P'd888d8888Rdbc
           `"*J*CJ8*d8888l:'  ``88?bl.o
           .o.sl.rsdP^*8bdbs.. *"?**l888s.
         ,`JYsd88P88ld?\**"`*`-. `  ` `"`
        dPJ88*J?P;Pd888D;=-.  -.l.s.
      .'`"*Y,.sbsdkC l.    ?(     ^.    l
           .Y8*?8P*"`       `)` .' :    b
             `"`         _.-'. ,   k.   s
                        (    : '  ('
               ------- ,'`-  )`.` `.l  ---
           r========-==-==-=-=-=------------=7
            `Y - -- ---- -- -   .          ,'
              :                       '   :
               \-.. .. .. . . . . .     ,/
           .-<=:`._____________________,'.:>-.
           L______                        ___J
                  ````````````````````````
  '';
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 80 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

