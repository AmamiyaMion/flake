{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./git.nix
    ./shells.nix
    ./ssh.nix
    ./nano.nix
    inputs.nix-index-database.homeModules.default
  ];

  xdg.userDirs.enable = true;
  xdg.userDirs.setSessionVariables = true;

  home.sessionVariables = rec {
    EDITOR = lib.mkDefault "nvim";
    VISUAL = EDITOR;
  };
}
