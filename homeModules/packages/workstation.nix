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
      foliate
      piper
      darktable
      # davinci-resolve
      gimp
      inkscape
      kdePackages.kdenlive
      krita
      wineWow64Packages.stagingFull
      winetricks
      pi-coding-agent
      splayer-next
    ]
  );
}
