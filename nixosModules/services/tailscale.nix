{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.tailscale.enable = true;
  services.tailscale.authKeyFile = config.sops.secrets.ts_authkey.path;
}
