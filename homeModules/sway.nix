{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.wayland.windowManager.sway;
in
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
  };

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      bars = [ ];
      fonts = lib.mkForce {
        names = [
          "Maple Mono Normal NF"
          "Noto Sans CJK SC"
        ];
        style = "Retina";
        size = 10.0;
      };
      terminal = "kitty";
      menu = "rofi -show drun";
      gaps.smartBorders = "on";
      workspaceAutoBackAndForth = true;
      window.titlebar = true;
      floating.titlebar = true;
      input = {
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          middle_emulation = "enabled";
          natural_scroll = "enabled";
        };
        "type:keyboard" = {
          xkb_options = ''"swap_lwin_lctl"'';
        };
      };
      keybindings =
        let
          inherit (cfg.config) modifier;
        in
        removeAttrs
          (lib.mkOptionDefault {
            "${modifier}+q" = "exec ${cfg.config.terminal}";
            "${modifier}+c" = "kill";
            "${modifier}+space" = "exec ${cfg.config.menu}";
            "${modifier}+Alt+Space" = "focus mode_toggle";
            "${modifier}+Shift+s" = ''exec sh -c "slurp | grim -g - - | wl-copy"'';
            "${modifier}+Alt+l" = "exec swaylock";
            "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
            "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
            "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
            "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
            "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          })
          [
            "${modifier}+Return"
            "${modifier}+Shift+q"
            "${modifier}+d"
          ];
      startup = [
        {
          command = "fcitx5";
          always = true;
        }
        { command = "clash-verge"; }
        { command = "mako"; }
        { command = "1password"; }
      ];
    };
  };

  home.packages = with pkgs; [
    brightnessctl
    swayidle
    swaylock
    wl-clipboard
    waybar
    slurp
    grim
    kitty
    thunar
    vlc
    catfish
    ristretto
  ];

  services.gnome-keyring.enable = true;
  services.mako.enable = true;
  services.wl-clip-persist.enable = true;

  xdg.portal.config.common.default = "*";
}
