{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Emacs
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacs-gtk;

  # Emacs as default editor
  environment.variables.EDITOR = "emacs -nw";
  environment.variables.VISUAL = "emacs -nw";
}
