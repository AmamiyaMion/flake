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
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    micro
    lshw
    gtop # for GNOME Shell Plugin
    pciutils
    nethogs
    iotop
    htop
    btop
    hplip
    ripgrep
    iw
    amdgpu_top
    piper
    bat
    sbctl
    tpm2-tss
    xclip
    wl-clipboard
    fd
    ispell
    libreoffice-fresh
    hunspell
    hunspellDicts.en_US
    zen-browser.default
    man-pages
  ];
}
