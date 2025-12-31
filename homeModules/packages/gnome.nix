{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = lib.mkOrder 502 (
    with pkgs;
    [
      gnome-software
      gnome-tweaks
    ]
  );
}
