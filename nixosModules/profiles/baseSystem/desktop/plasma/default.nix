{
  config,
  lib,
  pkgs,
  nixosModules,
  assetsPath,
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
  environment.systemPackages = lib.mkOrder 800 (
    with pkgs;
    [
      (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
        [General]
        background=${assetsPath}/lockscreen.png
      '')
      kdePackages.dragon
      kdePackages.kleopatra
      kdePackages.kamoso
      kdePackages.sddm-kcm
      kdePackages.krdc
      kdePackages.skanpage
      vlc
    ]
  );
}
