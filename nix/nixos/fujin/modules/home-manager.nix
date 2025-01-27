{
  imports = [./home.nix];

  options = {};

  config = {
    home-manager = {
      useGlobalPkgs = true;
      userUserPackages = true;
    };
  };

}

