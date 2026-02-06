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
      # Temporarily removing kdenlive for
      #   it fails to build aster nixpkgs
      #   PR #477464 merged
      # kdePackages.kdenlive
      krita
      wineWowPackages.stagingFull
      winetricks
    ]
  );
}
