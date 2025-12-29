{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.printing.enable = true;

  # Enable Avahi: for autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Drivers
  services.printing.drivers = with pkgs; [
    gutenprint
    gutenprintBin
    hplipWithPlugin
    postscript-lexmark
    samsung-unified-linux-driver
    splix
    brlaser
    brgenml1lpr
    brgenml1cupswrapper
    cnijfilter2
    epson-escpr2
    epson-escpr
  ];

  environment.systemPackages = lib.mkOrder 600 (
    with pkgs;
    [
      hplip
    ]
  );
}
