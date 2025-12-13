{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
  # boot.zfs.package = pkgs.zfs_cachyos;
  services.scx.enable = true; # Use sched_ext
  # For OBS Studio Virtual Camera: v4l2loopback kernel module
  # Fix: nixpkgs/nixos-unstable v4l2loopback broken on linux 6.18,
  # using package from nixpkgs/nixos-25.11
  boot.extraModulePackages = with config.boot.kernelPackages; [
    (v4l2loopback.overrideAttrs (
      finalAttrs: prevAttrs: {
        version = "0.15.3";
        src = pkgs.fetchFromGitHub {
          owner = "umlaeute";
          repo = "v4l2loopback";
          tag = "v0.15.3";
          hash = "sha256-KXJgsEJJTr4TG4Ww5HlF42v2F1J+AsHwrllUP1n/7g8=";
        };
      }
    ))
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
}
