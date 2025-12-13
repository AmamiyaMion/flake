{
  config,
  lib,
  pkgs,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mion = {
    isNormalUser = true;
    description = "Mion";
    extraGroups = ["wheel"];
    packages = with pkgs; [
      tree
      google-chrome
    ];
    shell = pkgs.zsh;
  };
  # for using zsh as shell
  programs.zsh.enable = true;
  environment.shells = with pkgs; [zsh];

  # Disable sudo. We use doas.
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [
    {
      users = ["mion"];
      keepEnv = true;
      noPass = true;
    }
  ];
  environment.systemPackages = lib.mkOrder 100 [pkgs.doas-sudo-shim];
}
