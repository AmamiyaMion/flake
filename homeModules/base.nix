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
}
