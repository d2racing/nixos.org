{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # -------------------------------------------------------
  # Bootloader
  # -------------------------------------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # -------------------------------------------------------
  # Basic System Settings
  # -------------------------------------------------------
  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: true;
  };

  # -------------------------------------------------------
  # Display Server + Qtile + LightDM
  # -------------------------------------------------------
  services.xserver = {
    enable = true;

    displayManager.lightdm.enable = true;

    windowManager.qtile = {
      enable = true;
      package = pkgs.qtile;
    };
  };

  # -------------------------------------------------------
  # Thunar + SMB (Synology support)
  # -------------------------------------------------------
  programs.thunar.enable = true;

  services.gvfs.enable = true;          
  services.tumbler.enable = true;       
  services.udisks2.enable = true;       

  # -------------------------------------------------------
  # AMD GPU Optimizations (Vulkan, VAAPI, HEVC, etc.)
  # -------------------------------------------------------
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;

    extraPackages = with pkgs; [
      mesa
      mesa.drivers
      amdvlk       # AMD Vulkan driver
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa.drivers
    ];

    setLdLibraryPath = true;
  };

  # Force RADV Vulkan implementation (better performance)
  environment.variables.AMD_VULKAN_ICD = "RADV";

  # Firmware (important for modern AMD GPUs)
  hardware.firmware = [ pkgs.linux-firmware ];

  # -------------------------------------------------------
  # Audio (PipeWire)
  # -------------------------------------------------------
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  hardware.pulseaudio.enable = false;

  # -------------------------------------------------------
  # Applications + Codecs + Tools
  # -------------------------------------------------------
  environment.systemPackages = with pkgs; [
    # Core desktop software
    google-chrome
    onepassword
    anydesk

    # Qtile ecosystem
    rofi
    picom
    pywal
    kitty
    nerdfonts

    # File management
    gvfs
    glib
    thunar-volman
    exfatprogs

    # Multimedia (full codec support)
    vlc
    ffmpeg-full
    libde265
    libheif
    heif-convert
    heifthumbnailer
    aom
    dav1d
    libvpx
    fdk_aac
    x264
    x265

    imagemagick

    # GPU/Vulkan tools
    vulkan-tools
    libva-utils
  ];

  # -------------------------------------------------------
  # Fonts
  # -------------------------------------------------------
  fonts.packages = with pkgs; [
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  # -------------------------------------------------------
  # Users
  # -------------------------------------------------------
  users.users.sylvain = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "password";  # Change after first login
  };

  # -------------------------------------------------------
  # Miscellaneous
  # -------------------------------------------------------
  services.printing.enable = true;
  security.sudo.enable = true;

  system.stateVersion = "24.11";
}
