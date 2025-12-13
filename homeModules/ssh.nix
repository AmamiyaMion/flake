{
  config,
  lib,
  pkgs,
  ...
}: {
  # Set up AOSC Buildbots ssh config
  home.file.".ssh/config.d/aosc".source = pkgs.fetchurl {
    url = "https://cdn.jsdelivr.net/gh/AOSC-Dev/Buildbots/ssh_config";
    sha256 = "sha256-nZtB6KZMmJZKOJ2iXA/kSFsorgj+DcmxOhyzvrD0/+8=";
  };
  home.file.".ssh/known_hosts.d/aosc".source = pkgs.fetchurl {
    url = "https://cdn.jsdelivr.net/gh/AOSC-Dev/Buildbots/ssh_known_hosts";
    sha256 = "sha256-CyvCX3ucpfckN9730BjXR46AVPafmEHO3wC+T3xQjWM=";
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    # 1Password SSH Agent
    # extraConfig = ''
    #   Host *
    #       IdentityAgent ~/.1password/agent.sock
    # '';
    matchBlocks."*".identityAgent = "~/.1password/agent.sock";
    matchBlocks."*".extraOptions = {
      Include = "config.d/*";
    };
  };
}
