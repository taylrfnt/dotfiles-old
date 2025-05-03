{
  description = "amaterasu nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nix-darwin,
    nixpkgs,
    # nixpkgs-master,
    nix-homebrew,
    home-manager,
    nvf,
    ...
    }: {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#<flake-name>
      darwinConfigurations."amaterasu" = nix-darwin.lib.darwinSystem {
        # specialArgs = {
        #   pkgs-master = import nixpkgs-master {
        #     system = "aarch64-darwin";
        #     config.allowUnfree = true;
        #   };
        # };
        modules = [
          ./configuration.nix
          nvf.nixosModules.default
          ./nvf.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true; # enable homebrew via nix
              enableRosetta = true; # Apple Silicon Only
              user = "taylor"; # User owning the Homebrew prefix
            };
          }
          home-manager.darwinModules.home-manager
          {
            # `home-manager` config
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.taylor = import ./home.nix;
          }
        ];
      };
  };

}

