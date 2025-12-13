{
  config,
  lib,
  pkgs,
  ...
}: {
  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true; # for tpm luks autounlock
  environment.systemPackages = lib.mkAfter (
    with pkgs; [
      sbctl
      tpm2-tss
    ]
  );
}
