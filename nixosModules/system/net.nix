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
    "9.9.9.9" # Quad9
    "119.29.29.29" # Tencent
    "1.1.1.1" # Cloudflare
    "223.5.5.5" # AliDNS
  ];
  networking.networkmanager.dns = "none";

  # services.stubby = {
  #   enable = true;
  #   settings =
  #     pkgs.stubby.passthru.settingsExample
  #     // {
  #       upstream_recursive_servers = [
  #         {
  #           address_data = "9.9.9.9";
  #           tls_auth_name = "dns.quad9.net";
  #           tls_pubkey_pinset = [
  #             {
  #               digest = "sha256";
  #               value = "i2kObfz0qIKCGNWt7MjBUeSrh0Dyjb0/zWINImZES+I=";
  #             }
  #           ];
  #         }
  #         {
  #           address_data = "1.1.1.1";
  #           tls_auth_name = "one.one.one.one";
  #           tls_pubkey_pinset = [
  #             {
  #               digest = "sha256";
  #               value = "SPfg6FluPIlUc6a5h313BDCxQYNGX+THTy7ig5X3+VA=";
  #             }
  #           ];
  #         }
  #         {
  #           address_data = "1.0.0.1";
  #           tls_auth_name = "one.one.one.one";
  #           tls_pubkey_pinset = [
  #             {
  #               digest = "sha256";
  #               value = "SPfg6FluPIlUc6a5h313BDCxQYNGX+THTy7ig5X3+VA=";
  #             }
  #           ];
  #         }
  #         {
  #           address_data = "119.29.29.29";
  #           tls_auth_name = "dot.pub";
  #           tls_pubkey_pinset = [
  #             {
  #               digest = "sha256";
  #               value = "5TIMjgyMhA0qmPdK+AM9LX6vNI/9EPBydh/ZXdfcYmI=";
  #             }
  #           ];
  #         }
  #       ];
  #     };
  # };
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
      server_names = ["quad9-dnscrypt-ip4-filter-pri" "cloudflare" "nextdns" "dnspod" "alidns-doh"];
    };
  };
}
