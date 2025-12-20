{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # Use Lix
  nixpkgs.overlays = [
    (final: prev: {
      inherit
        (prev.lixPackageSets.stable)
        nixpkgs-review
        nix-eval-jobs
        nix-fast-build
        colmena
        ;
    })
  ];

  nix.package = pkgs.lixPackageSets.latest.lix;

  # Enable nix command and flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Mirror
  nix.settings.substituters = [
    "https://mirror.sjtu.edu.cn/nix-channels/store"
    "https://attic.xuyh0120.win/lantian"
  ];
  nix.settings.trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="];

  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  # Enable automatic gc
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
    dates = "daily";
  };

  # Enable automatic store optimise
  nix.optimise.automatic = true;
  # Enable store optimise on build
  nix.settings.auto-optimise-store = true;

  # This is important. It locks nixpkgs registry used in nix shell
  # to the same of flakes. Saves time.
  nix.registry = {pkgs.flake = inputs.self;} // lib.mapAttrs (_: flakes: {flake = flakes;}) inputs;

  # direnv
  programs.direnv.enable = true;
}
