{
  config,
  lib,
  pkgs,
  assetsPath,
  ...
}:

{
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.limine = {
    enable = true;
    enableEditor = false;
    style = {
      wallpapers = [ "${assetsPath}/bootloader.png" ];
      interface = {
        branding = "limine bootloader (nixos)";
      };
    };
  };

}
