#!/bin/sh

# EALIS
# Experimental Arch Linux Install Script for VirtualBox.

# Prepare
loadkeys no
timedatectl set-ntp true

# Prepare installation
cfdisk
mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt
pacstrap /mnt base base-devel linux vim
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

# Chrooted
ln -sf /usr/share/zoneinfo/Europe/Oslo /etc/localtime
hwclock --systohc
vim /etc/locale.gen
locale-gen
echo "LANG=nb_NO.UTF-8" > /etc/locale.conf
echo "KEYMAP=no" > /etc/vconsole.conf
echo "arch" > /etc/hostname
echo "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\tarch.localdomain\tarch" >> /etc/hosts
passwd
pacman -S grub
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
exit
umount -R /mnt
