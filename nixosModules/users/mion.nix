{
  config,
  lib,
  pkgs,
  homeModules,
  inputs,
  ...
}@osSpecialArgs:
let
  username = "mion";
in
{
  options = {
    mion.homeManager = {
      enable = lib.mkEnableOption "Enable home-manager for Mion.";
      modules = lib.mkOption {
        default = [ ];
        description = "Extra modules for home-manager";
      };
    };
  };
  config = {
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
        users = [ username ];
        keepEnv = true;
        noPass = true;
      }
    ];
    environment.systemPackages = lib.mkOrder 100 [ pkgs.doas-sudo-shim ];

    home-manager = lib.mkIf config.mion.homeManager.enable {
      users."${username}" = {
        imports = [
          homeModules.base
        ]
        ++ config.mion.homeManager.modules;
        home.username = username;
        home.homeDirectory = "/home/${username}";
        home.stateVersion = "25.05";
        programs.home-manager.enable = true;
      };
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "bak";
      extraSpecialArgs = {
        inherit (osSpecialArgs)
          inputs
          system
          ;
        inherit username;
      };
    };
  };
}
