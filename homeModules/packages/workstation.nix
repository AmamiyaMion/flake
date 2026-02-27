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
      foliate
      piper
      darktable
      davinci-resolve
      gimp
      inkscape
      kdePackages.kdenlive
      krita
      wineWow64Packages.stagingFull
      winetricks
      teamspeak6-client
    ]
  );
}
