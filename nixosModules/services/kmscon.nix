{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.kmscon = {
    enable = true;
    hwRender = true;
    useXkbConfig = true;
    fonts = [
      {
        name = "Maple Mono Normal NF CN";
        package = pkgs.maple-mono.Normal-NF-CN;
      }
    ];
  };
}
