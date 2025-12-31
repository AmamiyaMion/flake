{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = lib.mkOrder 503 (
    with pkgs;
    [
      evolution
      telegram-desktop
      fractal
      wemeet
    ]
  );
}
