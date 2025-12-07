{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.bash = {
    enable = true;
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
  # Zoxide
  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;
}
