{
  description = "Amamiya Mion's flakes!";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nur.url = "github:nix-community/nur";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    mion-nur.url = "github:AmamiyaMion/nur";
    mion-nur.inputs.nixpkgs.follows = "nixpkgs";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    chaotic.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote/master";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-utils,
      flake-parts,
      home-manager,
      nur,
      mion-nur,
      chaotic,
      nix-flatpak,
      nixos-hardware,
      zen-browser,
      lanzaboote,
      ...
    }:
    {
      nixosConfigurations = {
        celeste = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ({
              nixpkgs.overlays = [
                (final: prev: {
                  mion-nur = inputs.mion-nur.packages."${prev.stdenv.hostPlatform.system}";
                  zen-browser = inputs.zen-browser.packages."${prev.stdenv.hostPlatform.system}";
                })
              ];
            })

            lanzaboote.nixosModules.lanzaboote # lanzaboote (Secure Boot)
            chaotic.nixosModules.default # Chaotic-Nyx Repository
            nixos-hardware.nixosModules.lenovo-ideapad-15ach6 # nixos-hardware 82L5

            ./machines/celeste/celeste.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs.flake-inputs = inputs;
              home-manager.users.mion = ./machines/celeste/home/home.nix;
            }
          ];
        };
      };
    };
}
