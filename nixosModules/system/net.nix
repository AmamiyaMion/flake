{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = lib.mkDefault true; # Easiest to use and most distros use this by default.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  networking.nameservers = [
    "119.29.29.29" # Tencent
    "9.9.9.9" # Quad9
    "1.1.1.1" # Cloudflare
    "223.5.5.5" # AliDNS
  ];
  networking.networkmanager.dns = "none";

  services.dnscrypt-proxy = {
    enable = true;
    # Settings reference:
    # https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
    settings = {
      ipv6_servers = true;
      require_dnssec = true;
      # Add this to test if dnscrypt-proxy is actually used to resolve DNS requests
      # query_log.file = "/var/log/dnscrypt-proxy/query.log";
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      server_names = [
        "dnspod"
        "quad9-dnscrypt-ip4-filter-pri"
        "cloudflare"
        "nextdns"
        "alidns-doh"
      ];
    };
  };
}
