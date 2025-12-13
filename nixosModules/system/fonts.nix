{
  config,
  lib,
  pkgs,
  ...
}: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    maple-mono.Normal-NF
    mion-nur.plangothic
  ];
  fonts.fontconfig = {
    antialias = true;
    hinting.enable = true;
    defaultFonts = {
      emoji = ["Noto Color Emoji"];
      monospace = ["Maple Mono Normal NF"];
      sansSerif = ["Noto Sans CJK SC"];
      serif = ["Noto Serif CJK SC"];
    };
  };
  fonts.fontconfig.useEmbeddedBitmaps = true;

  # for flatpak
  fonts.fontDir.enable = true;
}
