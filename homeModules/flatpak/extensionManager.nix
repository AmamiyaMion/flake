{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  services.flatpak = {
    packages = lib.mkOrder 500 [
      "com.mattjakeman.ExtensionManager"
    ];
  };
}
