{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.loader.efi.canTouchEfiVariables = true;
}
