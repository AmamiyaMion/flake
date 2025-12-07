{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.kmscon.enable = true;
  services.kmscon.hwRender = true;
}
