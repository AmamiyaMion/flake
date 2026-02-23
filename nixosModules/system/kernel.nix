{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.kernelPackages = lib.mkDefault pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;
  boot.zfs.package = config.boot.kernelPackages.zfs_cachyos;
  # services.scx.enable = lib.mkIf (pkgs.stdenv.system == "x86_64-linux") true; # Use sched_ext
  # services.scx.scheduler = "scx_lavd";
  # For OBS Studio Virtual Camera: v4l2loopback kernel module
  #
  # moved to device-wide settings, for CachyOS Kernel contains v4l2loopback by default
  # boot.extraModulePackages = with config.boot.kernelPackages; [
  #   v4l2loopback
  # ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
}
