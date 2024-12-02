# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, meta, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = meta.hostname; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.networkmanager.settings.connection."ipv4.method" = "auto";

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    #useXkbConfig = true; # use xkb.options in tty.
  };

  # Fixes for longhorn
  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];
  virtualisation.docker.logDriver = "json-file";

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  services.k3s = {
    enable = true;
    role = "server";
    tokenFile = /var/lib/rancher/k3s/server/token;
    extraFlags = toString ([
	    "--write-kubeconfig-mode \"0644\""
	    "--cluster-init"
	    "--disable servicelb"
	    "--disable traefik"
	    "--disable local-storage"
    ] ++ (if meta.hostname == "homelab-0" then [] else [
	      "--server https://homelab-0:6443"
    ]));
    clusterInit = (meta.hostname == "homelab-0");
  };

  services.openiscsi = {
    enable = true;
    name = "iqn.2016-04.com.open-iscsi:${meta.hostname}";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # enable zsh
  #programs.zsh.enable = true;
  #programs.zsh.shellAliases = {
  #  k = "kubectl";
  #};

  # Define shell aliases for bash
  programs.bash.shellAliases = {
    k = "kubectl";
    killk3s = "/usr/local/bin/k3s-killall.sh";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.taylor = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    # Created using mkpasswd
    hashedPassword = "$6$QHI78ky1rOZZkAOh$FCRwbkcpLynrwzuQ1shI6q5s3xav7ipfp4voxWxNZM7SKR5ga7RWhcmWPpFfb0jmTXObd39mvG9I.h4n3XJZx1";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDbMES1tgTg8Yxt85otagzi03dS5dXaUbq6HY9PrjI+3O8Q6szlKd2HBOP3O1RmBG2orHv0oK4KuEIhr/lypAanl4uFVxs49diQ7jjwFxFXlTQWcPdGRFu+8OXlqF15AUCe1tCo+xXruW3rJqDfQkkRlneU9iuDrF2Es/pSXdOslaBYQeMZLVifMZ7ENLsrEH7mdB9RTS1Xm+PuI1SYxCsifwPSxfaIcQwCB72iAN1xONNrh/XdzqtEQ877P/WWeJrlydzqaraU7x1f0RdgpS6mgJunruBcMu4Fb6lXuZx+116vMoYiVEMo0iOa6RkP7PZl2UuAumoHTy8TDMUFZDajczR21GZwsGY6OSZbndMcvijH/1DBm05rnKrRrHRxR9KznwBIYeUZFx3Z3XZZ3xCHRNuSYz0GnMICe/KWxwPltyLrP4zSEoz24ix1S/DUxttKKovnil38s1sCKZLaCyygg8p5qmVHqaM1ELccjyvtoxM69/cwhVK5/R8A9KKyEKU= SOURCE:Macmini"
   "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDA9/yQ+8yZ07ptd0xeaDlyEcweAzdwTzfkPHgVbU7YvKSs/05tqkvitPrFGzBoCm0HeBmHIYyYbhKMKokjm4xSDKt9qlNfRRuF7jSAI4BtNRniEsneX9tPXcLpg7OcZO8x5fJBbKqrQ17vYGJ4uP1arhmMvGtxv56jdEfw1/j2rlhdIOvfiR7cuMpoHBlk8M9pbo7uwjmhbPIk2YX+YFOvnRajXBSFAopZw6Nne9mGTcSrq2ke+WJO3UwUTGJ8S+P1Jdu9fd2qFqeZHIgebhKoU4IRbfvRNY+tle2bgUPcoihFi4kaoa2fh/0usAExKXW0Ab7U1lLlsh+CnuJrbaoTmeKA5N2AIABbUdAUL5TXxeUaX0fvmQ7yop8F7QoxrfSidkvdz4TWQbu49PH1pr9WgOjdyx3ddOZEm2gtTH6uElpIRxVAP+fr4bG0YtnoOJ6TVhoe91FDGSiYHnvWEMHVPQwz4Rm62GePcMogOyZwxTkStutBjZCDTHdKnosZR80= taylorfont@amaterasu"
   ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     neovim
     k3s
     cifs-utils
     nfs-utils
     git
     dig
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
  services.openssh.banner = "                                        \n   _                 _     _       ___  \n  | |_ ___ _____ ___| |___| |_ ___|   | \n  |   | . |     | -_| | .'| . |___| | | \n  |_|_|___|_|_|_|___|_|__,|___|   |___| \n                                        \n                                         \n\nWelcome to homelab.                   \n\n";

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
  system.stateVersion = "23.11"; # Did you read the comment?

}

