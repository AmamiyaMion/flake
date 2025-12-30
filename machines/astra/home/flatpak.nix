{
  config,
  lib,
  pkgs,
  flake-inputs,
  ...
}:
{
  imports = [
    flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "daily";
    };
    packages = [
      "com.github.tchx84.Flatseal"
      "com.mattjakeman.ExtensionManager"
      "com.gopeed.Gopeed"
      "org.localsend.localsend_app"
      "com.discordapp.Discord"
      "io.typora.Typora"
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
