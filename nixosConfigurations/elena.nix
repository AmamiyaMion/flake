{
  config,
  lib,
  pkgs,
  nixosModules,
  homeModules,
  ...
}:
{
  imports = [
    nixosModules.profiles.baseSystem.desktop.sway.default

    nixosModules.services.dae
    nixosModules.services.emacs
    nixosModules.services.kmscon
    nixosModules.services.clash-verge

    nixosModules.desktop._1password
  ];

  networking.hostName = "elena"; # Define your hostname.
  networking.hostId = "ffafeebc"; # For zfs; Make it random!

  mion.systemPackages.office.enable = true;
  mion.homeManager.modules = with homeModules; [
    vscode
    sway
    flatpak.default
    obs-studio.default
    packages.default
    packages.dev
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system/stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
