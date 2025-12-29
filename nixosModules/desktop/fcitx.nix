{
  config,
  lib,
  pkgs,
  ...
}:
{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      kdePackages.fcitx5-qt
      qt6Packages.fcitx5-chinese-addons
      fcitx5-table-extra
    ];
  };
}
