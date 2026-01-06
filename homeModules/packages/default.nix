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
      (lib.mkIf (stdenv.system == "x86_64-linux") microsoft-edge)
      fastfetch
      hyfetch
      nixfmt-rfc-style
      nixd
      file
      ffmpeg
      imagemagick
      emacs
      papers
      file-roller
    ]
  );

  # Enable nix-index
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  programs.television.enable = true;
  programs.nix-search-tv.enable = true;
  programs.nix-search-tv.enableTelevisionIntegration = true;
}
