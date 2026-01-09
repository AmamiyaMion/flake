{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = lib.mkOrder 501 (
    with pkgs;
    [
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
      gh
      go
      yarn
      pnpm
      nodejs
      github-desktop
      (lib.mkIf (pkgs.stdenv.system == "x86_64-linux") arduino-ide)
    ]
  );
}
