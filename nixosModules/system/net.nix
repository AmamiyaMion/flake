{
  config,
  lib,
  pkgs,
  ...
}: {
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  services.zerotierone.enable = true;

  networking.nameservers = [
    "9.9.9.9#dns.quad9.net" # Quad9
    "1.1.1.1#one.one.one.one" # Cloudflare
    "8.8.8.8#dns.google" # Google
    "119.29.29.29#dot.pub" # Tencent
    "223.5.5.5" # AliDNS
  ];

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [
      "9.9.9.9"
      "1.1.1.1"
      "1.0.0.1"
    ];
    dnsovertls = "true";
  };
  boot.initrd.services.resolved.enable = true;
}
