{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = lib.mkOrder 505 (
    with pkgs;
    [
      cider-2
      piper
      darktable
      davinci-resolve
      gimp
      inkscape
    ]
  );
}
