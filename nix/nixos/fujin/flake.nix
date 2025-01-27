{
  description =  "NixOS VM Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs,  ... }: {
    system = "aarch64-linux";
    nixosModules = {

      declarativeHome = { ... }: {
        config = {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.taylor = import ./home.nix;
        };
      };

      gnome = { pkgs, ... }: {
        config = {
          services = {
            xserver = {
              enable = true;
              displayManager.gdm.enable = true;
              desktopManager.gnome.enable = true;
            };
          };
          environment = {
            gnome = {
              excludePackages = (with pkgs; [
                gnome-photos
                gnome-tour
              ]) ++ (with pkgs.gnome; [
                gnome-characters
                gnome-initial-setup
              ]);
            };
            systemPackages = with pkgs; [
              gnome.gnome-tweaks
            ];
          };
          programs.dconf.enable = true;
        };
      };

    };

    nixosConfigurations = {
      fujin = {
        lib.nixosSystem {
          modules = with self.nixosModules; [
            ({ config = { nix.registry.nixpkgs.flake = nixpkgs; }; })
            home-manager.nixosModules.home-manager
            gnome
            declarativeHome
          ];
        };
      };
    };

  };

}

