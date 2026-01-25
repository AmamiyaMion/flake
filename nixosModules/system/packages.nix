{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mion.systemPackages = {
    office.enable = lib.mkEnableOption "Enable installation of office packages";
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
    ]
    ++ (lib.optionals config.mion.systemPackages.dev.enable [
      man-pages
      sequoia-chameleon-gnupg
      sequoia-sq
      sequoia-sqop
      sequoia-sqv
      sequoia-wot
      ciel
      squashfsTools
      dpkg
      rpm
    ])
    ++ (lib.optionals config.mion.systemPackages.office.enable [
      libreoffice-fresh
      hunspell
      hunspellDicts.en_US
      ispell
    ])
  );
}
