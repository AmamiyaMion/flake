{
  config,
  lib,
  pkgs,
  secretsPath,
  ...
}:
{
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.secrets.ts_authkey = {
    format = "json";
    sopsFile = "${secretsPath}/tailscale.json";
    restartUnits = [
      "tailscaled.service"
      "tailscaled-autoconnect.service"
    ];
  };
}
