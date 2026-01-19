{
  config,
  lib,
  pkgs,
  assetsPath,
  ...
}:
{
  options.mion.bootloader = {
    limine = {
      enable = lib.mkEnableOption "Use Limine (EFI) as bootloader";
      secureBoot.enable = lib.mkEnableOption "Use Secure Boot";
    };
    systemd-boot = {
      enable = lib.mkEnableOption "Use systemd-boot as bootloader";
    };
  };
  config = {
    assertions = [
      {
        assertion = !(config.mion.bootloader.limine.enable && config.mion.bootloader.systemd-boot.enable);
        message = "Only one of mion.bootloader.limine.enable and mion.bootloader.systemd-boot.enable can be set to true.";
      }
    ];
    boot.loader.limine = {
      inherit (config.mion.bootloader.limine) enable;
      secureBoot.enable = config.mion.bootloader.limine.secureBoot.enable;
      enableEditor = false;
      style = {
        wallpapers = [ "${assetsPath}/nix-wallpaper-nineish-pink.png" ];
        interface = {
          branding = "Limine Bootloader (NixOS)";
        };
      };
    };
    boot.loader.systemd-boot.enable = config.mion.bootloader.systemd-boot.enable;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.initrd.systemd.enable = true; # for tpm luks autounlock
    environment.systemPackages = lib.mkAfter (
      lib.optionals config.mion.bootloader.limine.secureBoot.enable (
        with pkgs;
        [
          sbctl
          tpm2-tss
        ]
      )
    );
  };
}
