{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mion = {
    isNormalUser = true;
    description = "Mion";
    extraGroups = [
      "wheel"
      "kvm"
      "adbusers"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrG7IrNH5u3LKXA/W9W/2yV+/lGXT9Ejl8FOhB28lus"
    ];
  };
  # for using zsh as shell
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  # Disable sudo. We use doas.
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [
    {
      users = [ "mion" ];
      keepEnv = true;
      noPass = true;
    }
  ];
  environment.systemPackages = lib.mkOrder 100 [ pkgs.doas-sudo-shim ];
}
