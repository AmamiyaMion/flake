# Amamiya Mion's NixOS Config

**This README.md contains AI generated contents.**

Personal NixOS and Home Manager configurations for three machines. The flake uses
NixOS unstable, Home Manager, and reusable modules for desktop environments,
services, packages, and user configuration.

This is a personal configuration rather than a drop-in distribution. Review the
hardware, users, secrets, and filesystem settings before using it on another
machine.

## Hosts

| Host | Platform | Desktop | Device Model |
| --- | --- | --- | --- |
| `astra` | `aarch64-linux` | Sway | Raspberry Pi 4 |
| `elena` | `x86_64-linux` | Sway | Xiaomi TM1607 |
| `celeste` | `x86_64-linux` | GNOME | Lenovo IdeaPad 15ACH6 |

Each host combines a configuration in `nixosConfigurations/` with its matching
hardware definition in `hardwares/`. The flake discovers these configurations
automatically.

## Repository Layout

- `flake.nix` - flake inputs, host generation, checks, formatter, and dev shell
- `nixosConfigurations/` - host-specific NixOS configuration
- `hardwares/` - generated and machine-specific hardware settings
- `nixosModules/` - reusable system, desktop, service, and profile modules
- `homeModules/` - reusable Home Manager and package modules
- `assets/` - wallpapers and other configuration assets
- `secrets/` - SOPS-encrypted secret files
- `Justfile` - shortcuts for rebuilding, updating, cleaning, and proxy control

## Requirements

- Nix with flakes enabled
- `sudo` access for system changes
- `git`
- `just` and `nh` for the provided command shortcuts
- An `age` key configured for SOPS if the selected host uses encrypted secrets

The development shell provides the project tools, including `nixd`, `nixfmt`,
`nh`, `just`, `sops`, `age`, `ssh-to-age`, `openssh`, `neovim`, and `statix`:

```sh
nix develop
```

With direnv installed, entering the repository automatically activates the flake
development shell through `.envrc`.

## Usage

Build or switch to a specific host with the standard NixOS command:

```sh
sudo nixos-rebuild switch --flake .#celeste
```

Replace `celeste` with `astra` or `elena` as needed. The repository also
provides `just` shortcuts for the current machine:

```sh
just rebuild       # switch to the new system
just boot          # build and select the new system at next boot
just update        # update flake inputs
just gc            # remove old Nix generations
just optimise      # optimise the Nix store
```

Running `just` with no arguments pulls the repository, updates flake inputs, and
rebuilds the current host.

Before applying changes, run the flake checks and formatter:

```sh
nix flake check
nix fmt
statix check
```

## Secrets

Secrets are managed with [sops-nix](https://github.com/Mic92/sops-nix) and
`age`. The repository expects the host key at
`/var/lib/sops-nix/key.txt`; do not commit plaintext secrets. To edit an
encrypted secret, use:

```sh
sops secrets/tailscale.json
```

The SOPS rules and authorized age keys are defined in `.sops.yaml`.

## Inspiration

This configuration is heavily inspired by [Noa Virellia's flake (legacy
branch)](https://github.com/AsterisMono/flake/tree/legacy). Thanks for her
work!

Licensed under the [MIT License](./LICENSE).
