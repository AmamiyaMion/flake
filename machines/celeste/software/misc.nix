{
  config,
  lib,
  pkgs,
  ...
}:
{
  # ratbagd (for piper)
  services.ratbagd.enable = true;
}
