{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_zen;
  # boot.zfs.package = pkgs.zfs_cachyos;
  services.scx.enable = lib.mkIf (pkgs.stdenv.system == "x86_64-linux") true; # Use sched_ext
  services.scx.scheduler = "scx_lavd";
  # For OBS Studio Virtual Camera: v4l2loopback kernel module
  # Fix: nixpkgs/nixos-unstable v4l2loopback broken on linux 6.18,
  # using package from nixpkgs/nixos-25.11
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
}
