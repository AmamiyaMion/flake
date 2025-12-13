{
  config,
  lib,
  pkgs,
  ...
}: {
  # 1Password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = ["mion"];
  };
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        google-chrome-stable
        firefox
        zen
        zen-bin
      '';
      mode = "0755";
    };
  };
}
