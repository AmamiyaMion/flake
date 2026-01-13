{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = lib.mkOrder 500 (
    with pkgs;
    [
      (if (stdenv.system == "x86_64-linux") then google-chrome else chromium)
      floorp-bin
      fastfetch
      hyfetch
      nixfmt
      nixd
      file
      ffmpeg
      imagemagick
      emacs
      qbittorrent-enhanced
    ]
  );

  # Enable nix-index
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  programs.television.enable = true;
  programs.nix-search-tv.enable = true;
  programs.nix-search-tv.enableTelevisionIntegration = true;
}
