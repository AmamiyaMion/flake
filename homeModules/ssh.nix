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
    hash = "sha256-6pohGMYCDs4IkI3F+0lz7nEizbyxe/geWxv/9SLccJc=";
  };
  home.file.".ssh/known_hosts.d/aosc".source = pkgs.fetchurl {
    url = "https://cdn.jsdelivr.net/gh/AOSC-Dev/Buildbots/ssh_known_hosts";
    hash = "sha256-ryCZdGTss5ly7of7upSRDaOcgC+q+N8GeRPIu+9g8C0=";
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
