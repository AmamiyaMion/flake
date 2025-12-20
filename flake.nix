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
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote/master";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
  };

  outputs = inputs: let
    makeNixosSystem = {
      hostname,
      system,
    }:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          {
            nixpkgs.overlays = [
              (final: prev: {
                nur = inputs.nur.packages."${prev.stdenv.hostPlatform.system}";
                mion-nur = inputs.mion-nur.packages."${prev.stdenv.hostPlatform.system}";
                zen-browser = inputs.zen-browser.packages."${prev.stdenv.hostPlatform.system}";
              })
              inputs.nix-cachyos-kernel.overlay
            ];
          }
          ./machines/${hostname}/${hostname}.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs.flake-inputs = inputs;
            home-manager.users.mion = ./machines/${hostname}/home/home.nix;
          }
        ];
      };
  in {
    nixosConfigurations = {
      celeste = makeNixosSystem {
        hostname = "celeste";
        system = "x86_64-linux";
      };
      elena = makeNixosSystem {
        hostname = "elena";
        system = "x86_64-linux";
      };
    };
    formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;

    devShells.x86_64-linux.default = let
      inherit (inputs.nixpkgs.legacyPackages.x86_64-linux) pkgs;
    in
      pkgs.mkShell {
        name = "Amamiya Mion's Nix dev shell";
        buildInputs = with pkgs; [
          nixd
          alejandra
          nh
          just
          openssl
        ];
        EDITOR = "emacs -nw";
      };
  };
}
