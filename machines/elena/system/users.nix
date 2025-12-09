{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mion = {
    isNormalUser = true;
    description = "Mion";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      google-chrome
    ];
  };

  # sudo NOPASSWD
  security.sudo.extraRules = [
    {
      users = [ "mion" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
