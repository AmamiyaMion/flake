{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  services.flatpak = {
    packages = lib.mkOrder 200 [
      "com.qq.QQ"
      "com.tencent.WeChat"
      "com.discordapp.Discord"
    ];
    overrides = {
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
