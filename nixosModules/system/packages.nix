{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mion.systemPackages = {
    workstation.enable = lib.mkEnableOption "Enable installation of workstation packages";
    dev.enable = lib.mkEnableOption "Enable installation of system-level developers' packages";
  };
  config.environment.systemPackages = lib.mkOrder 300 (
    with pkgs;
    [
      tree
      git
      bat
      fd
      pciutils
      nethogs
      iotop
      htop
      btop
      neovim
      helix
      usbutils
      wget
      micro
      lshw
      ripgrep
      iw
      eza
      nh
    ]
    ++ (lib.optionals config.mion.systemPackages.dev.enable [
      man-pages
      ciel
      squashfsTools
      dpkg
      rpm
    ])
    ++ (lib.optionals config.mion.systemPackages.workstation.enable [
      libreoffice-fresh
      hunspell
      hunspellDicts.en_US
      ispell
      bitwarden-desktop
    ])
  );
}
