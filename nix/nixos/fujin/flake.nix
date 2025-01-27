{
  description = "NixOS Dev VM flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = @inputs{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      fujin = {
        system = "aarch64-linux";
        modules = with self.nixosModules; [
          ./configuration.nix
          gnome = (import ./modules/gnome.nix { inherit config pkgs; });
          home-manager = (import ./modules/home-manager.nix { inherit config pkgs;});
        ];
      }
    }

  };

}

