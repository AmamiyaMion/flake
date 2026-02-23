{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  nix.package = pkgs.nixVersions.latest;
  # Enable nix command and flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.substituters = [
    "https://mirror.sjtu.edu.cn/nix-channels/store" # Mirror
    "https://cache.garnix.io" # Garnix Cache
    "https://cache.nixos-cuda.org" # CUDA
    "https://attic.xuyh0120.win/lantian" # CachyOS Kernel
  ];
  nix.settings.trusted-public-keys = [
    "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
  ];

  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  services.angrr = {
    enable = true;
    settings = {
      temporary-root-policies = {
        direnv = {
          path-regex = "/\\.direnv/";
          period = "7d";
        };
        result = {
          path-regex = "/result[^/]*$";
          period = "3d";
        };
      };
      profile-policies = {
        system = {
          profile-paths = [ "/nix/var/nix/profiles/system" ];
          keep-since = "14d";
          keep-latest-n = 5;
          keep-booted-system = true;
          keep-current-system = true;
        };
        user = {
          enable = true; # Policies can be individually disabled
          profile-paths = [
            # `~` at the beginning will be expanded to the home directory of each discovered user
            "~/.local/state/nix/profiles/profile"
            "/nix/var/nix/profiles/per-user/root/profile"
          ];
          keep-since = "1d";
          keep-latest-n = 1;
        };
        # You can define your own policies
        # ...
      };
    };
  };
  # Enable automatic gc
  nix.gc = {
    automatic = true;
    # options = "--delete-older-than 7d";
    dates = "daily";
  };

  # Enable automatic store optimise
  nix.optimise.automatic = true;
  # Enable store optimise on build
  nix.settings.auto-optimise-store = true;

  # This is important. It locks nixpkgs registry used in nix shell
  # to the same of flakes. Saves time.
  nix.registry = {
    pkgs.flake = inputs.self;
  }
  // lib.mapAttrs (_: flakes: { flake = flakes; }) inputs;

  # direnv
  programs.direnv.enable = true;
}
