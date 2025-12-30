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
      (lib.hiPrio gcc)
      gdb
      llvm
      lld
      lldb
      clang
      cmake
      uv
      python313Packages.python-lsp-server
      rust-analyzer
      clang-tools
      guile
      xmake
      just
      psmisc
      gnumake
      meson
      ninja
      cargo
      rustc
      android-tools
      nixfmt-rfc-style
      nixd
      gh
      go
      file
      yarn
      pnpm
      nodejs
      ffmpeg
      imagemagick
      emacs
    ]
  );

  # Enable nix-index
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
}
