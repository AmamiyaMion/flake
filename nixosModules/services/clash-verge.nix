{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Clash Verge Rev
  programs.clash-verge.enable = true;
  programs.clash-verge.autoStart = true;
  programs.clash-verge.serviceMode = true;
}
