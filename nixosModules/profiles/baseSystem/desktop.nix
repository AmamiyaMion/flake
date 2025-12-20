{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../system/binary-compatibility.nix
    ../../system/bluetooth.nix
    ../../system/cups.nix
    ../../system/fonts.nix
    ../../system/kernel.nix
    ../../system/net.nix
    ../../system/nix.nix
    ../../system/secrets.nix
    ../../system/tzlocale.nix
    ../../system/packages.nix
    ../../system/users.nix

    ../../desktop/fcitx.nix
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable power-profiles-daemon
  services.power-profiles-daemon.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # FireFox
  programs.firefox.enable = true;

  # Flatpak
  # More configurations are placed in the home-manager nix-flatpak module.
  services.flatpak.enable = true;

  # PolicyKit
  security.polkit.enable = true;

  programs.adb.enable = true;

  environment.systemPackages = lib.mkOrder 700 (
    with pkgs; [
      xclip
      wl-clipboard
    ]
  );
}
