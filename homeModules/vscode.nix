{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (
      ps: with ps; [
        rustup
        zlib
        openssl.dev
        pkg-config
        gcc
        clang
        llvm
        gdb
        lldb
        lld
        cmake
        ninja
        gnumake
        meson
      ]
    );
  };
}
