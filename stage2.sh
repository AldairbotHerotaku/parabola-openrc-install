#/bin/bash
rm -rf /etc/pacman.conf
cp /sigoff /etc/pacman.conf
locale-gen
mkinitcpio -p linux-libre
grub-install --target=x86_64-efi --efi-directory=/boot/ --bootloader-id="Parabola linux"
pacman -S update-grub
update-grub
rc-update add NetworkManager default
pacman -S pipewire pipewire-alsa pipewire-jack pipewire-pulse alsa-utils
pacman -S sudo
pacman -S xfce4 xfce4-goodies 
clear
echo "Make an user"
read $user
useradd -m $user
clear 
echo "Make a password for that user"
passwd $user
gpasswd -a $user wheel
gpasswd -a $user video
gpasswd -a $user audio
rm -rf /etc/pacman.conf
cp /sigon /etc/pacman.conf
