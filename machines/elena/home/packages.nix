{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    gnome-tweaks
    telegram-desktop
    papers
    github-desktop
    file-roller
  ];
}
