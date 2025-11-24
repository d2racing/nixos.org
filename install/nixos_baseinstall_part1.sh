#!/bin/bash
echo 'start of baseinstall_part1.sh'

export BOOT_DISK="/dev/sda"
export BOOT_PART="1"
export BOOT_DEVICE="${BOOT_DISK}${BOOT_PART}"

echo $BOOT_DISK
echo $BOOT_PART
echo $BOOT_DEVICE 

export SWAP_DISK="/dev/sda"
export SWAP_PART="2"
export SWAP_DEVICE="${SWAP_DISK}${SWAP_PART}"

echo $SWAP_DISK
echo $SWAP_PART
echo $SWAP_DEVICE 

export ROOT_DISK="/dev/sda"
export ROOT_PART="3"
export ROOT_DEVICE="${ROOT_DISK}${ROOT_PART}"

echo $ROOT_DISK
echo $ROOT_PART
echo $ROOT_DEVICE
# 
mkfs.fat -F 32 -n boot $BOOT_DEVICE
mkfs.ext4 -L nixos $ROOT_DEVICE
mkswap -L swap $SWAP_DEVICE

mount /dev/$ROOT_DEVICE /mnt
mount --mkdir $BOOT_DEVICE /mnt/boot
swapon $SWAP_DEVICE
mount -t efivarfs efivarfs /sys/firmware/efi/efivars
lsblk

nixos-generate-config --root /mnt
echo 'end of baseinstall_part1.sh' 
