{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  services.flatpak = {
    packages = lib.mkOrder 400 [
      "io.typora.Typora"
    ];
  };
}
