{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;

    extraPackages = with pkgs; [
      mesa
      mesa_drivers
      vaapiVdpau
      libvdpau-va-gl
      amdvlk
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa.drivers
    ];

    setLdLibraryPath = true;
  };

  environment.variables.AMD_VULKAN_ICD = "RADV";

  hardware.firmware = [ pkgs.linux-firmware ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "kernel.nmi_watchdog" = 0;
  };
}
