{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = "雨宮 澪音";
      user.email = "amamiya_mion@aosc.io";
      commit.gpgsign = true;
      tag.gpgSign = true;
      user.signingKey = "31829672594B6DD8";
    };
  };
}
