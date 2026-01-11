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
        "dialout"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrG7IrNH5u3LKXA/W9W/2yV+/lGXT9Ejl8FOhB28lus"
      ];
      initialHashedPassword = "$y$j9T$Vsin.O/77yAEFX9TtN.iB.$yHa.h5gxC0NP5NXBrZ3Ivhhf79NeHA2j/.9xM4MGSX8";
    };
    # for using zsh as shell
    programs.zsh.enable = true;
    environment.shells = with pkgs; [ zsh ];

    # Disable sudo. We use sudo-rs.
    security.sudo.enable = false;
    security.sudo-rs.enable = true;
    security.sudo-rs.wheelNeedsPassword = false;

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
      backupFileExtension = "home-manager-backup";
      extraSpecialArgs = {
        inherit (osSpecialArgs)
          inputs
          assetsPath
          system
          ;
        inherit username;
      };
    };
  };
}
