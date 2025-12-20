{
  config,
  lib,
  pkgs,
  secretsPath,
  ...
}: {
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.secrets.ts_authkey = {
    format = "yaml";
    sopsFile = "${secretsPath}/tailscale.yaml";
    restartUnits = [
      "tailscaled.service"
      "tailscaled-autoconnect.service"
    ];
  };
}
