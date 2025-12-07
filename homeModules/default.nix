{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./git.nix
    ./shells.nix
    ./ssh.nix
    ./vscode.nix
    ./packages.nix
  ];
}
