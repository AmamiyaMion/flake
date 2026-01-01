{
  config,
  lib,
  pkgs,
  nixosModules,
  ...
}:
{
  imports = with nixosModules.profiles.baseSystem; [
    desktop.default
  ];

  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.gnome-user-share.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.gnome-browser-connector.enable = true;
  services.gnome.gnome-remote-desktop.enable = true;
  programs.seahorse.enable = true;

  # GSConnect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  environment.systemPackages = lib.mkOrder 800 (
    with pkgs;
    [
      gtop # for GNOME Shell Plugin
      adw-gtk3
      gnome-software
      gnome-tweaks
    ]
  );
}
