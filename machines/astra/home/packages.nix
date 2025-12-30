{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    gnome-tweaks
    evolution
    telegram-desktop
    fractal
    papers
    github-desktop
    gnome-software
    file-roller
  ];
}
