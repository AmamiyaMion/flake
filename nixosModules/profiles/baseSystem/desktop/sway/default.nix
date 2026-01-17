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
  programs.sway.enable = true;
  programs.sway.wrapperFeatures.gtk = true;
  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = { };

  programs.waybar.enable = true; # top bar
  environment.systemPackages = lib.mkOrder 650 (
    with pkgs;
    [
      kitty
      rofi
      swaylock
      mako
      swayidle
      xwayland-satellite
      grim
      slurp
      wl-clipboard
      papers
      file-roller
    ]
  );
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd sway";
        user = "greeter";
      };
    };
  };

  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
