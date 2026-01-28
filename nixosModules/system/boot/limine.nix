{
  config,
  lib,
  pkgs,
  assetsPath,
  ...
}:

{
  boot.loader.limine = {
    enable = true;
    enableeditor = false;
    style = {
      wallpapers = [ "${assetspath}/nix-wallpaper-nineish-pink.png" ];
      interface = {
        branding = "limine bootloader (nixos)";
      };
    };
  };

}
