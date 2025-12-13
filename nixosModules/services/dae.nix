{
  config,
  lib,
  pkgs,
  ...
}: {
  services.dae.enable = true;
  services.dae.config = ''
    global {
      log_level: info
      wan_interface: auto
      dial_mode: domain
      allow_insecure: true
      auto_config_kernel_parameter: true
      tcp_check_url: 'http://cp.cloudflare.com,1.1.1.1,2606:4700:4700::1111'
      tcp_check_http_method: HEAD
    }
    node {
      clash: 'socks5://localhost:7890'
    }
    dns {
      upstream {
        dnspod: 'udp://119.29.29.29:53'
        googledns: 'https://dns.google/dns-query'
      }
      routing {
        request {
          fallback: dnspod
        }
        response {
          upstream(googledns) -> accept
          !qname(geosite:cn) && ip(geoip:private) -> googledns
          fallback: accept
        }
      }
    }
    group {
      clash {
        policy: fixed(0)
      }
    }
    # 参考 https://github.com/daeuniverse/dae/blob/main/docs/routing.md
    routing {
      pname(dnsmasq, systemd-resolved) && l4proto(udp) && dport(53) -> must_direct
      pname(NetworkManager) -> direct

      # clash 代理客户端直连，防止网络回环
      pname(clash) -> must_direct
      pname(clash-meta) -> must_direct
      pname(qemu-system-x86) -> must_direct
      pname(clash-verge-service) -> must_direct
      pname(verge-mihomo) -> must_direct
      pname(verge-mihomo-alpha) -> must_direct
      pname(mihomo) -> must_direct
      pname(mihomo-alpha) -> must_direct
      pname(clash-verge) -> must_direct

      # 需要指定代理的网站或进程
      domain(suffix: bing.com) -> clash

      # 需要指定直连的网站或进程
      domain(suffix: cm.steampowered.com) -> direct
      domain(suffix: steamserver.net) -> direct
      pname(qbittorrent) -> direct
      pname(wechat) -> must_direct
      pname(WeChatAppEx) -> must_direct
      pname(crashpad_handler) -> must_direct
      pname(qq) -> must_direct
      pname(tailscaled) -> must_direct
      pname(tailscale) -> must_direct

      dip(224.0.0.0/3, 'ff00::/8') -> direct
      dip(geoip:private) -> direct
      dip(geoip:cn) -> direct
      domain(geosite:cn) -> direct

      fallback: clash
    }
  '';
}
