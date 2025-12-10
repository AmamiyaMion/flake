{
  config,
  lib,
  pkgs,
  flake-inputs,
  ...
}:

{
  imports = [
    ./git.nix
    ./shells.nix
    ./ssh.nix
    ./vscode.nix
    ./packages.nix
    
    flake-inputs.nix-index-database.homeModules.default
  ];
}
