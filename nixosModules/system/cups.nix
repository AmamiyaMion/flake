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
    (lib.mkIf (stdenv.system == "x86_64-linux") gutenprintBin)
    hplipWithPlugin
    postscript-lexmark
    samsung-unified-linux-driver
    splix
    brlaser
    (lib.mkIf (stdenv.system == "x86_64-linux") brgenml1lpr)
    (lib.mkIf (stdenv.system == "x86_64-linux") brgenml1cupswrapper)
    (lib.mkIf (stdenv.system == "x86_64-linux") mion-nur.cnijfilter2)
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
