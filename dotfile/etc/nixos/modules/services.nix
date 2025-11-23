{ config, pkgs, ... }:

{
  # SMB / GVFS
  services.gvfs.enable = true;

  # Printing
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
