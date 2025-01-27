{
  imports = [];

  options = {};

  config = {

    environment = {
      gnome = {
        excludePackages = (with pkgs; [
          gnome-photos
          gnome-tour
        ]) ++ (with pkgs.gnome; [
          gnome-initial-setup
        ]);
        systemPackages = with pkgs; [
          gnome.gnome-tweaks
        ];
      };
    };

    services = {
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };

    programs.dconf.enable = true;
  };
}

