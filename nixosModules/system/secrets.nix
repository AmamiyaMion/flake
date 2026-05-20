{
  config,
  lib,
  pkgs,
  secretsPath,
  ...
}:
{
  sops.age.keyFile = "/persist/etc/ssh/ssh_host_ed25519_key";
  sops.secrets.ts_authkey = {
    format = "json";
    sopsFile = "${secretsPath}/tailscale.json";
    restartUnits = [
      "tailscaled.service"
      "tailscaled-autoconnect.service"
    ];
  };
}
