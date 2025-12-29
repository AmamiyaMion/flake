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
    ./nano.nix
    ./emacs.nix

    flake-inputs.nix-index-database.homeModules.default
  ];
}
