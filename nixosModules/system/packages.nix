{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mion.systemPackages.office.enable =
    lib.mkEnableOption "Enable installation of office packages";
  config.environment.systemPackages = lib.mkOrder 300 (
    with pkgs;
    [
      tree
      git
      man-pages
      bat
      fd
      pciutils
      nethogs
      iotop
      htop
      btop
      neovim
      helix
      wget
      micro
      lshw
      ripgrep
      iw
      sequoia-chameleon-gnupg
      sequoia-sq
      sequoia-sqop
      sequoia-sqv
      sequoia-wot
      eza
    ]
    ++ (lib.optionals config.mion.systemPackages.office.enable [
      libreoffice-fresh
      hunspell
      hunspellDicts.en_US
      ispell
    ])
  );
}
