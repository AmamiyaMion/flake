{
  config,
  lib,
  pkgs,
  ...
}:

{
  virtualisation.docker = {
    enable = true;
    # Customize Docker daemon settings using the daemon.settings option
    daemon.settings = {
      log-driver = "journald";
      registry-mirrors = [ "https://docker.1ms.run" ];
      storage-driver = "overlay2";
    };
  };
}
