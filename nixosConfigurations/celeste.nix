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
  # `celeste` is a stateless NixOS. Mind your steps when bootstrapping.
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-ideapad-15ach6 # nixos-hardware 82L5
    inputs.preservation.nixosModules.default

    nixosModules.profiles.baseSystem.desktop.gnome.default

    # nixosModules.services.libvirt
    nixosModules.services.virtualbox
    nixosModules.services.dae
    nixosModules.services.kmscon
    nixosModules.services.clash-verge
    nixosModules.services.podman

    nixosModules.desktop.steam
    nixosModules.desktop._1password
  ];

  networking.hostName = "celeste"; # Define your hostname.
  networking.hostId = "a12be02d"; # For zfs; Make it random!

  mion.systemPackages.dev.enable = true;
  mion.systemPackages.workstation.enable = true;
  mion.homeManager.enable = true;
  mion.homeManager.modules = with homeModules; [
    default
    helix
    vscode
    ghostty
    # emacs
    flatpak.default
    flatpak.chatApps
    flatpak.typora
    obs-studio.default
    obs-studio.cuda
    packages.default
    packages.chatApps
    packages.dev
    packages.workstation
    packages.games
    packages.spotify
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

  # preservation: for a stateless NixOS
  preservation = {
    enable = true;
    preserveAt."/persist" = {
      commonMountOptions = [
        "x-gvfs-hide"
      ];
      directories = [
        "/etc/NetworkManager/system-connections"
        "/var/lib/bluetooth"
        "/var/lib/fprint"
        "/var/lib/libvirt"
        "/var/lib/power-profiles-daemon"
        "/var/lib/systemd/coredump"
        "/var/lib/systemd/rfkill"
        "/var/lib/systemd/timers"
        "/var/lib/sbctl"
        {
          directory = "/var/lib/sops-nix";
          mode = "0700";
          inInitrd = true;
        }
        "/var/lib/AccountsService"
        "/var/log"
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
      ];
      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
        {
          file = "/etc/ssh/ssh_host_rsa_key";
          how = "symlink";
          configureParent = true;
          inInitrd = true;
        }
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
          how = "symlink";
          configureParent = true;
          inInitrd = true;
        }
        {
          file = "/var/lib/systemd/random-seed";
          how = "symlink";
          inInitrd = true;
          configureParent = true;
        }
      ];
      users = {
        root = {
          home = "/root";
          directories = [
            {
              directory = ".ssh";
              mode = "0700";
            }
          ];
        };
        mion = {
          directories = [
            {
              directory = ".ssh";
              mode = "0700";
            }
            {
              directory = ".gnupg";
              mode = "0700";
            }

            ".config/1Password"
            ".config/AirPodsTrayApp"
            ".config/autostart"
            ".config/Code"
            ".config/darktable"
            ".config/dconf"
            ".config/Element"
            ".config/evolution"
            ".config/fcitx5"
            ".config/go"
            ".config/Google"
            ".config/google-chrome"
            ".config/inkscape"
            ".config/io.github.clash-verge-rev.clash-verge-rev"
            ".config/lazygit"
            ".config/libreoffice"
            ".config/mozilla"
            ".config/nvim"
            ".config/obs-studio"
            ".config/op"
            ".config/qBittorrent"
            ".config/qt6ct"
            ".config/sh.cider.genten"
            ".config/simple-scan"
            ".config/spotify"
            ".config/TeamSpeak"
            ".config/VirtualBox"
            ".config/vlc"

            ".local/lib"
            ".local/state/comma"
            ".local/state/nvim"
            ".local/state/wireplumber"
            ".local/state/nix"

            {
              directory = ".local/share/applications";
              mode = "0700";
            }
            ".local/share/backgrounds"
            ".local/share/direnv"
            ".local/share/BrainfuckChallenge"
            ".local/share/Celeste"
            ".local/share/clash-verge"
            ".local/share/com.github.johnfactotum.Foliate"
            ".local/share/DaVinciResolve"
            ".local/share/epiphany"
            ".local/share/Euro Truck Simulator 2"
            ".local/share/evolution"
            {
              directory = ".local/share/fcitx5";
              mode = "0700";
            }
            {
              directory = ".local/share/flatpak";
              mode = "0700";
            }
            ".local/share/gnome-calendar"
            ".local/share/gnome-settings-daemon"
            {
              directory = ".local/share/gnome-shell";
              mode = "0700";
            }
            ".local/share/Google"
            ".local/share/icons"
            ".local/share/io.github.clash-verge-rev.clash-verge-rev"
            {
              directory = ".local/share/keyrings";
              mode = "0700";
            }
            ".local/share/krita"
            ".local/share/mime"
            ".local/share/nvim"
            ".local/share/neovide"
            ".local/share/org.gnome.Evolution"
            ".local/share/pnpm"
            ".local/share/PrismLauncher"
            ".local/share/qBittorrent"
            ".local/share/shapez.io"
            ".local/share/Steam"
            ".local/share/TelegramDesktop"
            ".local/share/Trash"
            ".local/share/uv"
            ".local/share/vlc"
            ".local/share/wemeetapp"
            ".local/share/zoxide"

            ".mozilla"
            ".floorp"
            ".steam"
            ".vscode"
            ".hplip"
            ".var"

            "Public"
            "Documents"
            "Templates"
            "Music"
            "Downloads"
            "Pictures"
            "Desktop"
            "Videos"
            "Projects"
          ];
          files = [
            ".histfile"
            ".zsh_history"
            ".config/hyfetch.json"
            ".config/mimeapps.list"
            ".local/share/recently-used.xbel"
            ".local/share/user-places.xbel"
          ];
        };
      };
    };
  };
  systemd.tmpfiles.settings.preservation = {
    "/home/mion/.config".d = {
      user = "mion";
      group = "users";
      mode = "0755";
    };
    "/home/mion/.local".d = {
      user = "mion";
      group = "users";
      mode = "0755";
    };
    "/home/mion/.local/share".d = {
      user = "mion";
      group = "users";
      mode = "0755";
    };
    "/home/mion/.local/state".d = {
      user = "mion";
      group = "users";
      mode = "0755";
    };
  };
  # systemd-machine-id-commit.service would fail, but it is not relevant
  # in this specific setup for a persistent machine-id so we disable it
  #
  # see the firstboot example below for an alternative approach
  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];

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
