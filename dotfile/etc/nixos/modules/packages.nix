{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Browsers & productivity
    google-chrome
    onepassword
    anydesk

    # Media
    vlc
    ffmpeg-full
    libheif
    heif-convert
    heifthumbnailer
    aom
    dav1d
    libvpx
    fdk_aac
    x264
    x265
    vulkan-tools
    vulkan-loader
    libva-utils

    # File manager + SMB support
    thunar
    thunar-volman
    gvfs
    gvfs-smb
    gvfs-nfs
    cifs-utils
    exfatprogs

    # Utilities
    htop
    git
    unzip
    p7zip
    imagemagick
    networkmanagerapplet

    # Fonts
    noto-fonts
    noto-fonts-emoji
    nerdfonts
  ];
}
