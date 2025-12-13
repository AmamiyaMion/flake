{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    gnome-tweaks
    evolution
    telegram-desktop
    fractal
    papers
    darktable
    davinci-resolve
    github-desktop
    gnome-software
    file-roller
    wemeet
    cider-2
    piper
  ];
}
