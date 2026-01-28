{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true; # for tpm luks autounlock
}
