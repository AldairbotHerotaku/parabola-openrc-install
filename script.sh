#/bin/bash
echo "Before continue the installation make sure that you already modified it"
echo "If not Press Ctrl+C or Ctrl+Z if yes press enter"
read
#
# Fix signatures
#
cp /etc/pacman.conf /etc/pacman.conf.new
rm -rf /etc/pacman.conf
cp pacman-sigoff /etc/pacman.conf
sudo pacman --needed -Syy archlinux-keyring parabola-keyring
#
#  Partitions
# (Modify this)
# 

# Edit
cfdisk
# Format
mkfs.vfat /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3
# Mount and make boot
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

#
# Install base
#
pacstrap /mnt base libelogind udev-init-scripts dbus-openrc linux-libre linux-libre-headers networkmanager networkmanager-openrc elogind grub wpa_supplicant

#
# Genfstab and configs
#
genfstab -p /mnt >> /mnt/etc/fstab
clear
echo "Enter your hostname"
read hostname
echo $hostname >> /mnt/etc/hostname
echo hostname="$hostname" >> /mnt/etc/conf.d/hostname
cat > /mnt/etc/hosts <<EOF
127.0.0.1	localhost
::1		localhost
127.0.1.1	$hostname.localdomain	$hostname
EOF
clear
echo "Enter your timezone like America/Tijuana"
read timezone
ln -sf /mnt/usr/share/zoneinfo/$timezone /mnt/etc/localtime
clear
echo "Enter your locale like es_MX.UTF-8, en_US.UTF-8"
read locale
echo LANG=$locale >> /mnt/etc/locale.conf
echo $locale >> /mnt/etc/locale.gen 
clear
cp /mnt/etc/pacman.conf /mnt/etc/pacman.conf.new
rm -rf /mnt/etc/pacman.conf
cp pacman-sigon /mnt/etc/pacman.conf

cp pacamn-sigon /mnt/sigon
cp pacamn-sigoff /mnt/sigoff

#
# Chroot and install de (desktop..)
#
chmod +x /mnt/stage2.sh
arch-chroot /mnt /stage2.sh
