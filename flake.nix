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
    nix-cachyos-kernel.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      flake-utils,
      nixpkgs,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      secretsPath = ./secrets;
      modulesFromDirectoryRecursive =
        _dirPath:
        lib.packagesFromDirectoryRecursive {
          callPackage = path: _: import path;
          directory = _dirPath;
        };
      makeNixosSystem =
        {
          hostname,
          system,
        }:
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit secretsPath;
            inherit (self) nixosModules;
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
            inputs.sops-nix.nixosModules.sops
            ./machines/${hostname}/${hostname}.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = ".bak";
              home-manager.extraSpecialArgs.flake-inputs = inputs;
              home-manager.users.mion = ./machines/${hostname}/home/home.nix;
            }
          ];
        };
    in
    {
      nixosModules = modulesFromDirectoryRecursive ./nixosModules;
      nixosConfigurations = {
        astra = makeNixosSystem {
          hostname = "astra";
          system = "aarch64-linux";
        };
        celeste = makeNixosSystem {
          hostname = "celeste";
          system = "x86_64-linux";
        };
        elena = makeNixosSystem {
          hostname = "elena";
          system = "x86_64-linux";
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: {

      formatter = inputs.nixpkgs.legacyPackages.${system}.nixfmt-tree;

      devShells.default =
        let
          inherit (inputs.nixpkgs.legacyPackages.${system}) pkgs;
        in
        pkgs.mkShell {
          name = "Amamiya Mion's Nix dev shell";
          buildInputs = with pkgs; [
            nixd
            nixfmt-rfc-style
            nh
            just
            openssl
            sops
            age
          ];
          EDITOR = "emacs -nw";
        };
    });
}
