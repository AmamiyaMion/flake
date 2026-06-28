{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.kmscon = {
    enable = true;
    config.hwaccel = true;
    useXkbConfig = true;
    config.font-name = "Maple Mono Normal NF";
  };
}
