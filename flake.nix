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
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";
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
      assetsPath = ./assets;
      secretsPath = ./secrets;
      modulesFromDirectoryRecursive =
        _dirPath:
        lib.packagesFromDirectoryRecursive {
          callPackage = _path: _: import _path;
          directory = _dirPath;
        };
      globalSpecialArgs = {
        inherit
          inputs
          secretsPath
          assetsPath
          ;
        inherit (self)
          nixosModules
          homeModules
          ;
      };
    in
    {
      nixosModules = modulesFromDirectoryRecursive ./nixosModules;
      homeModules = modulesFromDirectoryRecursive ./homeModules;
      nixosConfigurations = lib.packagesFromDirectoryRecursive {
        callPackage =
          _path: _:
          let
            hostname = lib.removeSuffix ".nix" (baseNameOf _path);
            system = if hostname == "astra" then "aarch64-linux" else "x86_64-linux";
          in
          lib.nixosSystem {
            specialArgs = globalSpecialArgs // {
              inherit hostname system;
            };
            modules = [
              _path
              ./hardwares/${hostname}.nix
              inputs.home-manager.nixosModules.home-manager
              inputs.sops-nix.nixosModules.sops
              {
                nixpkgs.overlays = [
                  (final: prev: {
                    nur = inputs.nur.packages."${prev.stdenv.hostPlatform.system}";
                    mion-nur = inputs.mion-nur.packages."${prev.stdenv.hostPlatform.system}";
                  })
                ];
              }
            ];
          };
        directory = ./nixosConfigurations;
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: {

      formatter = inputs.nixpkgs.legacyPackages.${system}.nixfmt-tree;

      checks = {
        pre-commit-check = inputs.git-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixfmt.enable = true;
          };
        };
      };

      devShells.default =
        let
          inherit (inputs.nixpkgs.legacyPackages.${system}) pkgs;
          inherit (self.checks.${system}.pre-commit-check) shellHook enabledPackages;
        in
        pkgs.mkShell {
          name = "Amamiya Mion's Nix dev shell";
          buildInputs =
            (with pkgs; [
              nixd
              nixfmt
              nh
              just
              openssl
              sops
              age
              ssh-to-age
              openssh
              neovim
            ])
            ++ enabledPackages;
          inherit shellHook;
          EDITOR = "nvim";
        };
    });
}
