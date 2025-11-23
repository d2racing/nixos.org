{ config, pkgs, ... }:

{
  ###########################################################
  # IMPORTS
  ###########################################################
  imports = [
    ./hardware-configuration.nix
    ./modules/qtile.nix
    ./modules/packages.nix
    ./modules/hardware-amd.nix
    ./modules/services.nix
  ];

  ###########################################################
  # HOSTNAME & NETWORKING
  ###########################################################
  networking.hostName = "nixos-desktop";
  networking.networkmanager.enable = true;

  ###########################################################
  # LOCALE & TIMEZONE
  ###########################################################
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  ###########################################################
  # USERS
  ###########################################################
  users.users.yourUserName = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "password"; # change after first login
  };

  security.sudo.enable = true;

  ###########################################################
  # SYSTEM STATE VERSION
  ###########################################################
  system.stateVersion = "24.11";  # adjust to your NixOS version
}
