{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Set up AOSC Buildbots ssh config
  home.file.".ssh/config.d/aosc".source = pkgs.fetchurl {
    url = "https://cdn.jsdelivr.net/gh/AOSC-Dev/Buildbots/ssh_config";
    hash = "sha256-8LhvtGVfQy+BecLqdGfZ4ncjofcR4TxtILqoiUYEhgE=";
  };
  home.file.".ssh/known_hosts.d/aosc".source = pkgs.fetchurl {
    url = "https://cdn.jsdelivr.net/gh/AOSC-Dev/Buildbots/ssh_known_hosts";
    hash = "sha256-z9H+8U4MCfMpPtOW4MdcA+KamoMn3LkqpQVC/MaKneo=";
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    # 1Password SSH Agent
    # extraConfig = ''
    #   Host *
    #       IdentityAgent ~/.1password/agent.sock
    # '';
    settings."*" = {
      IdentityAgent = "~/.1password/agent.sock";
      Include = "config.d/*";
    };
  };
}
