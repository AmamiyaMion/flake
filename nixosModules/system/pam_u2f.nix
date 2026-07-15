{
  config,
  lib,
  pkgs,
  ...
}:

{
  security.pam.u2f.enable = true;
  security.pam.u2f.settings.cue = true;
}
