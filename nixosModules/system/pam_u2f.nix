{
  config,
  lib,
  pkgs,
  ...
}:

{
  security.pam.u2f.enable = true;
}
