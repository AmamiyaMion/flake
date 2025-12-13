{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = lib.mkOrder 300 (
    with pkgs; [
      git
      man-pages
      bat
      fd
      pciutils
      nethogs
      iotop
      htop
      btop
      vim
      wget
      micro
      lshw
      ripgrep
      iw
    ]
  );
}
