{
  config,
  lib,
  pkgs,
  inputs,
  nixosModules,
  homeModules,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-ideapad-15ach6 # nixos-hardware 82L5

    nixosModules.profiles.baseSystem.desktop.plasma.default

    nixosModules.services.libvirt
    nixosModules.services.dae
    nixosModules.services.kmscon
    nixosModules.services.clash-verge

    nixosModules.desktop.steam
    nixosModules.desktop._1password
  ];

  networking.hostName = "celeste"; # Define your hostname.
  networking.hostId = "a12be02d"; # For zfs; Make it random!

  mion.systemPackages.dev.enable = true;
  mion.systemPackages.office.enable = true;
  mion.homeManager.enable = true;
  mion.homeManager.modules = with homeModules; [
    default
    helix
    vscode
    ghostty
    emacs
    flatpak.default
    flatpak.chatApps
    flatpak.bottles
    flatpak.extensionManager
    flatpak.typora
    obs-studio.default
    obs-studio.cuda
    packages.default
    packages.chatApps
    packages.dev
    packages.workstation
    packages.games
  ];

  # ratbagd (for piper)
  services.ratbagd.enable = true;

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
