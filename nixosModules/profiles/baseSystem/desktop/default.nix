{
  config,
  lib,
  pkgs,
  nixosModules,
  ...
}:
{
  imports = with nixosModules; [
    profiles.baseSystem.default

    desktop.fcitx
    services.tailscale
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable `tlp` for power management
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    pd.enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    };
  };

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

  environment.systemPackages = lib.mkOrder 700 (
    with pkgs;
    [
      xclip
      wl-clipboard
      android-tools
    ]
  );
}
