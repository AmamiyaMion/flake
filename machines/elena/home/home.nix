{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./packages.nix
    ./flatpak.nix
    ./obs-studio.nix
    ../../../homeModules
    ../../../homeModules/sway.nix
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mion";
  home.homeDirectory = "/home/mion";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
