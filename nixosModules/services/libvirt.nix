{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "mion" ];
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_full;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = [ pkgs.virtiofsd ];
}
