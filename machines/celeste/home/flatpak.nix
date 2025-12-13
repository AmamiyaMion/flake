{
  config,
  lib,
  pkgs,
  flake-inputs,
  ...
}: {
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
      "com.qq.QQ"
      "com.tencent.WeChat"
      "com.usebottles.bottles"
      "org.localsend.localsend_app"
      "com.discordapp.Discord"
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
      "com.tencent.WeChat".Context = {
        filesystems = [
          "xdg-download/WeChat"
        ];
      };
      "com.qq.QQ".Context = {
        filesystems = [
          "xdg-download/QQ"
        ];
      };
    };
  };
}
