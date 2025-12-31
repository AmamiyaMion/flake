{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  services.flatpak = {
    packages = lib.mkOrder 300 [
      "com.usebottles.bottles"
    ];
  };
}
