{
  config,
  lib,
  pkgs,
  ...
}:
{
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    ispell
    libreoffice-fresh
    hunspell
    hunspellDicts.en_US
    freerdp
  ];
}
