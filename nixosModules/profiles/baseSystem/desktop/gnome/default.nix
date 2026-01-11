{
  config,
  lib,
  pkgs,
  nixosModules,
  ...
}:
{
  imports = with nixosModules.profiles.baseSystem; [
    desktop.default
  ];

  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.gnome-user-share.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.gnome-browser-connector.enable = true;
  services.gnome.gnome-remote-desktop.enable = true;
  services.gnome.gnome-software.enable = true;
  programs.seahorse.enable = true;
  services.gnome.sushi.enable = true;

  # GSConnect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  # Use ghostty by default
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ghostty";
  };
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "ghostty.desktop"
      ];
    };
  };

  environment.systemPackages = lib.mkOrder 800 (
    (with pkgs; [
      # for GNOME Shell Plugin
      gtop
      lm_sensors

      adw-gtk3
      mission-center
      gnome-tweaks
      ghostty
      qadwaitadecorations-qt6
      file-roller
      papers
    ])
    ++ (with pkgs.gnomeExtensions; [
      appindicator
      astra-monitor
      auto-adwaita-colors
      blur-my-shell
      caffeine
      clipboard-indicator
      coverflow-alt-tab
      dash-to-dock
      fuzzy-app-search
      gsconnect
      kimpanel
      light-style
      removable-drive-menu
      rounded-window-corners-reborn
      system-monitor
      transparent-window-moving
      user-avatar-in-quick-settings
      user-themes
    ])
  );
  environment.variables = {
    QT_WAYLAND_DECORATION = "adwaita";
  };
}
