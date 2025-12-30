{
  config,
  lib,
  pkgs,
  ...
}:

{
  # for this Raspberry Pi, we use wpa_supplicant and declarative network
  #   configuration, instead of NetworkManager, because sometimes it works in
  #   a headless environment, making connecting nto wireless networks via
  #   NetworkManager hard.
  networking.networkmanager.enable = false;
  networking.wireless.enable = true;
  networking.dhcpcd.enable = true;
  networking.wireless.networks = {
    "ChinaNet-P7NZVZ" = {
      pskRaw = "ec7dedff625021dc199f5469c3ab76addc4367f89d729bd08725c9658b329a16";
    };
    "Redmi Note 11T Pro" = {
      pskRaw = "a16b1b5a84164de629bc20c722f79dbeb82ef320fd369b23c79df71c241543f9";
    };
  };
}
