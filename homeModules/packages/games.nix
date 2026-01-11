{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = lib.mkOrder 506 (
    with pkgs;
    [
      prismlauncher
    ]
  );
}
