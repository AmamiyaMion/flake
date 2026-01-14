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
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;
  programs.kde-pim.enable = true;
  programs.kde-pim.kmail = true;
  programs.kde-pim.kontact = true;
  environment.systemPackages = lib.mkOrder 800 (
    with pkgs;
    [
      kdePackages.dragon
      kdePackages.kleopatra
      kdePackages.kmail
      kdePackages.kmail-account-wizard
      kdePackages.kmailtransport
      kdePackages.kamoso
      kdePackages.sddm-kcm
      vlc
    ]
  );
}
