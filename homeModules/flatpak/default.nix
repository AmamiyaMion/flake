{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "daily";
    };
    packages = lib.mkOrder 100 [
      "com.github.tchx84.Flatseal"
      "com.gopeed.Gopeed"
      "org.localsend.localsend_app"
    ];
    overrides = {
      global.Context = {
        filesystems = [
          "/home/mion/.local/share/fonts:ro"
          "/home/mion/.icons:ro"
          "/nix/store:ro"
          "/run/current-system/sw/share/X11/fonts:ro"
        ];
      };
    };
  };
}
