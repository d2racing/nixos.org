{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    windowManager.qtile = {
      enable = true;
      package = pkgs.qtile;
    };

    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "qtile";
  };

  environment.systemPackages = with pkgs; [
    qtile
    picom
    rofi
    kitty
  ];

  # Autostart script
  environment.etc."qtile/autostart.sh".source = ./../qtile-autostart.sh;

  system.activationScripts.qtileAutostart = ''
    chmod +x /etc/qtile/autostart.sh
  '';
}
