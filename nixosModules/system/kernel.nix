{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Remove CachyOS Kernel for its binary cache is down
  # boot.kernelPackages = lib.mkDefault pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;
  # boot.zfs.package = config.boot.kernelPackages.zfs_cachyos;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # services.scx.enable = lib.mkIf (pkgs.stdenv.system == "x86_64-linux") true; # Use sched_ext
  # services.scx.scheduler = "scx_lavd";
}
