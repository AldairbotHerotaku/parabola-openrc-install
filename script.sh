#/bin/bash
echo "Before continue the installation make sure that you already modified it"
echo "If not Press Ctrl+C or Ctrl+Z if yes press enter"
read
#
# Fix signatures
#

cat > /etc/pacman.conf <<EOF
#
# /etc/pacman.conf
#
# See the pacman.conf(5) manpage for option and repository directives

#
# GENERAL OPTIONS
#
[options]
# The following paths are commented out with their default values listed.
# If you wish to use different paths, uncomment and update the paths.
#RootDir     = /
#DBPath      = /var/lib/pacman/
#CacheDir    = /var/cache/pacman/pkg/
#LogFile     = /var/log/pacman.log
#GPGDir      = /etc/pacman.d/gnupg/
#HookDir     = /etc/pacman.d/hooks/
HoldPkg     = pacman glibc
#XferCommand = /usr/bin/curl -L -C - -f -o %o %u
#XferCommand = /usr/bin/wget --passive-ftp -c -O %o %u
#CleanMethod = KeepInstalled
Architecture = x86_64

# Pacman won't upgrade packages listed in IgnorePkg and members of IgnoreGroup
#IgnorePkg   =
#IgnoreGroup =

#NoUpgrade   =
#NoExtract   =

# Misc options
#UseSyslog
ILoveCandy
Color
#NoProgressBar
CheckSpace
#VerbosePkgLists
#ParallelDownloads = 5

# By default, pacman accepts packages signed by keys that its local keyring
# trusts (see pacman-key and its man page), as well as unsigned packages.
SigLevel    = Never
#Required DatabaseOptional
LocalFileSigLevel = Optional
#RemoteFileSigLevel = Required

# NOTE: You must run `pacman-key --init` before first using pacman; the local
# keyring can then be populated with the keys of all trusted packagers with:
#   `pacman-key --populate archlinux parabola`.

#
# REPOSITORIES
#   - can be defined here or included from another file
#   - pacman will search repositories in the order defined here
#   - local/custom mirrors can be added here or in separate files
#   - repositories listed first will take precedence when packages
#     have identical names, regardless of version number
#   - URLs will have $repo replaced by the name of the current repo
#   - URLs will have $arch replaced by the name of the architecture
#
# Repository entries are of the format:
#       [repo-name]
#       Server = ServerName
#       Include = IncludePath
#
# The header [repo-name] is crucial - it must be present and
# uncommented to enable the repo.
#
# Some repositories are disabled by default. To enable them, un-comment the
# repo name header (e.g. '[nonprism]') and the following 'Include' line.
# You can add preferred servers for each repo between the header and "Include" line,
# according to the format in /etc/pacman.d/mirrorlist,
# and those will be preferred over the standard mirrors for that repo.
#
# The order in which these entries appear in this file is critical.
# Much of the Parabola magic that supports advanced features such as
# multiple init-systems and multiple layers of freedom and privacy,
# depends on the order in which these repos are defined.
# Moving or adding repos out of the expected order can make your system insane.

# Notes on special repositories:
#
# Non-prism is a repository for enhanced privacy, beyond the FSDG requirements.
# It contains specially patched versions of certain software from the standard repos,
# that are known to include privacy-sensative features that some people may want to use,
# but that others may consider to be undesirable anti-features.
# For more info see: https://wiki.parabola.nu/Nonprism
#
# The non-systemd repository contains packages that are important and relevant only to
# Parabola systems using an init-system other than systemd.
# Parabola systems using systemd SHOULD NOT have [nonsystemd] enabled.
# Parabola systems using any other init-system SHOULD have [nonsystemd] enabled.
#
# The kernels repository contains additional special kernels for particular use-cases,
# such as maximal security hardening and real-time systems.
#
# The PCR (Parabola Community Repository) contains additional packages,
# most often requested by Parabola users, that are not considered to be
# part of the standard Parabola/Arch system, but are nonetheless useful or fun.
#
# Multi-lib repositories allow 32-bit applications to run on x86_64 systems.
#
# The Parabola system also supports custom, user-defined, repositories;
# but be aware that the Parabola team can not recommend nor support their use.
# The Parabola team can only support the use of software that is published by Parabola.
# The use of third-party software is discouraged with a "use at your own risk" warning.
# These may be community-maintained or maintained privately by the local user or sysadmin.
# They may be hosted on the internet, on the local network, or only on the local computer.
# An example of a custom package repository is given below
# in the "User-defined repos" section
# See the pacman manpage for details on creating your own repositories.


###########################
# Parabola standard repos #
###########################

#[nonprism-testing]
#Include = /etc/pacman.d/mirrorlist

[nonprism]
Include = /etc/pacman.d/mirrorlist

#[nonsystemd-testing]
#Include = /etc/pacman.d/mirrorlist

[nonsystemd]
Include = /etc/pacman.d/mirrorlist

#[libre-testing]
#Include = /etc/pacman.d/mirrorlist

[libre]
Include = /etc/pacman.d/mirrorlist

#[kernels-testing]
#Include = /etc/pacman.d/mirrorlist

#[kernels]
#Include = /etc/pacman.d/mirrorlist


#######################
# Arch standard repos #
#######################

#[testing]
#Include = /etc/pacman.d/mirrorlist

[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

#[community-testing]
#Include = /etc/pacman.d/mirrorlist

[community]
Include = /etc/pacman.d/mirrorlist


######################
# Supplemental repos #
######################

#[pcr-testing]
#Include = /etc/pacman.d/mirrorlist

[pcr]
Include = /etc/pacman.d/mirrorlist


############################
# Cross-architecture repos #
############################

#[nonprism-multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[nonprism-multilib]
#Include = /etc/pacman.d/mirrorlist

#[nonsystemd-multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[nonsystemd-multilib]
#Include = /etc/pacman.d/mirrorlist

#[libre-multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[libre-multilib]
#Include = /etc/pacman.d/mirrorlist

#[multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[multilib]
#Include = /etc/pacman.d/mirrorlist

#[pcr-multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[pcr-multilib]
#Include = /etc/pacman.d/mirrorlist


######################
# User-defined repos #
######################

#[custom]
#SigLevel = Optional TrustAll
#Server = file:///home/custompkgs


##############
# Over-rides #
##############

#Include = /etc/pacman.d/*.conf
EOF

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
make /mnt/boot
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
cat > /mnt/etc/locale.conf <<EOF
LANG=$locale
EOF
echo $locale >> /mnt/etc/locale.gen 
clear
cat > /mnt/etc/pacman.conf <<EOF
#
# /etc/pacman.conf
#
# See the pacman.conf(5) manpage for option and repository directives

#
# GENERAL OPTIONS
#
[options]
# The following paths are commented out with their default values listed.
# If you wish to use different paths, uncomment and update the paths.
#RootDir     = /
#DBPath      = /var/lib/pacman/
#CacheDir    = /var/cache/pacman/pkg/
#LogFile     = /var/log/pacman.log
#GPGDir      = /etc/pacman.d/gnupg/
#HookDir     = /etc/pacman.d/hooks/
HoldPkg     = pacman glibc
#XferCommand = /usr/bin/curl -L -C - -f -o %o %u
#XferCommand = /usr/bin/wget --passive-ftp -c -O %o %u
#CleanMethod = KeepInstalled
Architecture = x86_64

# Pacman won't upgrade packages listed in IgnorePkg and members of IgnoreGroup
#IgnorePkg   =
#IgnoreGroup =

#NoUpgrade   =
#NoExtract   =

# Misc options
#UseSyslog
ILoveCandy
Color
#NoProgressBar
CheckSpace
#VerbosePkgLists
#ParallelDownloads = 5

# By default, pacman accepts packages signed by keys that its local keyring
# trusts (see pacman-key and its man page), as well as unsigned packages.
SigLevel    = Never
#Required DatabaseOptional
LocalFileSigLevel = Optional
#RemoteFileSigLevel = Required

# NOTE: You must run `pacman-key --init` before first using pacman; the local
# keyring can then be populated with the keys of all trusted packagers with:
#   `pacman-key --populate archlinux parabola`.

#
# REPOSITORIES
#   - can be defined here or included from another file
#   - pacman will search repositories in the order defined here
#   - local/custom mirrors can be added here or in separate files
#   - repositories listed first will take precedence when packages
#     have identical names, regardless of version number
#   - URLs will have $repo replaced by the name of the current repo
#   - URLs will have $arch replaced by the name of the architecture
#
# Repository entries are of the format:
#       [repo-name]
#       Server = ServerName
#       Include = IncludePath
#
# The header [repo-name] is crucial - it must be present and
# uncommented to enable the repo.
#
# Some repositories are disabled by default. To enable them, un-comment the
# repo name header (e.g. '[nonprism]') and the following 'Include' line.
# You can add preferred servers for each repo between the header and "Include" line,
# according to the format in /etc/pacman.d/mirrorlist,
# and those will be preferred over the standard mirrors for that repo.
#
# The order in which these entries appear in this file is critical.
# Much of the Parabola magic that supports advanced features such as
# multiple init-systems and multiple layers of freedom and privacy,
# depends on the order in which these repos are defined.
# Moving or adding repos out of the expected order can make your system insane.

# Notes on special repositories:
#
# Non-prism is a repository for enhanced privacy, beyond the FSDG requirements.
# It contains specially patched versions of certain software from the standard repos,
# that are known to include privacy-sensative features that some people may want to use,
# but that others may consider to be undesirable anti-features.
# For more info see: https://wiki.parabola.nu/Nonprism
#
# The non-systemd repository contains packages that are important and relevant only to
# Parabola systems using an init-system other than systemd.
# Parabola systems using systemd SHOULD NOT have [nonsystemd] enabled.
# Parabola systems using any other init-system SHOULD have [nonsystemd] enabled.
#
# The kernels repository contains additional special kernels for particular use-cases,
# such as maximal security hardening and real-time systems.
#
# The PCR (Parabola Community Repository) contains additional packages,
# most often requested by Parabola users, that are not considered to be
# part of the standard Parabola/Arch system, but are nonetheless useful or fun.
#
# Multi-lib repositories allow 32-bit applications to run on x86_64 systems.
#
# The Parabola system also supports custom, user-defined, repositories;
# but be aware that the Parabola team can not recommend nor support their use.
# The Parabola team can only support the use of software that is published by Parabola.
# The use of third-party software is discouraged with a "use at your own risk" warning.
# These may be community-maintained or maintained privately by the local user or sysadmin.
# They may be hosted on the internet, on the local network, or only on the local computer.
# An example of a custom package repository is given below
# in the "User-defined repos" section
# See the pacman manpage for details on creating your own repositories.


###########################
# Parabola standard repos #
###########################

#[nonprism-testing]
#Include = /etc/pacman.d/mirrorlist

[nonprism]
Include = /etc/pacman.d/mirrorlist

#[nonsystemd-testing]
#Include = /etc/pacman.d/mirrorlist

[nonsystemd]
Include = /etc/pacman.d/mirrorlist

#[libre-testing]
#Include = /etc/pacman.d/mirrorlist

[libre]
Include = /etc/pacman.d/mirrorlist

#[kernels-testing]
#Include = /etc/pacman.d/mirrorlist

#[kernels]
#Include = /etc/pacman.d/mirrorlist


#######################
# Arch standard repos #
#######################

#[testing]
#Include = /etc/pacman.d/mirrorlist

[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

#[community-testing]
#Include = /etc/pacman.d/mirrorlist

[community]
Include = /etc/pacman.d/mirrorlist


######################
# Supplemental repos #
######################

#[pcr-testing]
#Include = /etc/pacman.d/mirrorlist

[pcr]
Include = /etc/pacman.d/mirrorlist


############################
# Cross-architecture repos #
############################

#[nonprism-multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[nonprism-multilib]
#Include = /etc/pacman.d/mirrorlist

#[nonsystemd-multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[nonsystemd-multilib]
#Include = /etc/pacman.d/mirrorlist

#[libre-multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[libre-multilib]
#Include = /etc/pacman.d/mirrorlist

#[multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[multilib]
#Include = /etc/pacman.d/mirrorlist

#[pcr-multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[pcr-multilib]
#Include = /etc/pacman.d/mirrorlist


######################
# User-defined repos #
######################

#[custom]
#SigLevel = Optional TrustAll
#Server = file:///home/custompkgs


##############
# Over-rides #
##############

#Include = /etc/pacman.d/*.conf
EOF


#
# Chroot and install de (desktop..)
#

cat > /mnt/stage2.sh <<EOF
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
if [ -d /home/$user ];
then
cat > /home/$user/.bashrc <<EOF
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startxfce4
EOF
else
mkdir /home/$user/
cat > /home/$user/.bashrc <<EOF
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startxfce4
EOF
fi
cat > /etc/sudoers <<EOF
## sudoers file.
##
## This file MUST be edited with the 'visudo' command as root.
## Failure to use 'visudo' may result in syntax or file permission errors
## that prevent sudo from running.
##
## See the sudoers man page for the details on how to write a sudoers file.
##

Defaults rootpw

##
## Host alias specification
##
## Groups of machines. These may include host names (optionally with wildcards),
## IP addresses, network numbers or netgroups.
# Host_Alias	WEBSERVERS = www1, www2, www3

##
## User alias specification
##
## Groups of users.  These may consist of user names, uids, Unix groups,
## or netgroups.
# User_Alias	ADMINS = millert, dowdy, mikef

##
## Cmnd alias specification
##
## Groups of commands.  Often used to group related commands together.
# Cmnd_Alias	PROCESSES = /usr/bin/nice, /bin/kill, /usr/bin/renice, \
# 			    /usr/bin/pkill, /usr/bin/top
# Cmnd_Alias	REBOOT = /sbin/halt, /sbin/reboot, /sbin/poweroff

##
## Defaults specification
##
## You may wish to keep some of the following environment variables
## when running commands via sudo.
##
## Locale settings
# Defaults env_keep += "LANG LANGUAGE LINGUAS LC_* _XKB_CHARSET"
##
## Run X applications through sudo; HOME is used to find the
## .Xauthority file.  Note that other programs use HOME to find   
## configuration files and this may lead to privilege escalation!
# Defaults env_keep += "HOME"
##
## X11 resource path settings
# Defaults env_keep += "XAPPLRESDIR XFILESEARCHPATH XUSERFILESEARCHPATH"
##
## Desktop path settings
# Defaults env_keep += "QTDIR KDEDIR"
##
## Allow sudo-run commands to inherit the callers' ConsoleKit session
# Defaults env_keep += "XDG_SESSION_COOKIE"
##
## Uncomment to enable special input methods.  Care should be taken as
## this may allow users to subvert the command being run via sudo.
# Defaults env_keep += "XMODIFIERS GTK_IM_MODULE QT_IM_MODULE QT_IM_SWITCHER"
##
## Uncomment to use a hard-coded PATH instead of the user's to find commands
# Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
##
## Uncomment to send mail if the user does not enter the correct password.
# Defaults mail_badpass
##
## Uncomment to enable logging of a command's output, except for
## sudoreplay and reboot.  Use sudoreplay to play back logged sessions.
## Sudo will create up to 2,176,782,336 I/O logs before recycling them.
## Set maxseq to a smaller number if you don't have unlimited disk space.
# Defaults log_output
# Defaults!/usr/bin/sudoreplay !log_output
# Defaults!/usr/local/bin/sudoreplay !log_output
# Defaults!REBOOT !log_output
# Defaults maxseq = 1000

##
## Runas alias specification
##

##
## User privilege specification
##
root ALL=(ALL:ALL) ALL
$user ALL=(ALL:ALL) ALL
## Uncomment to allow members of group wheel to execute any command
# %wheel ALL=(ALL:ALL) ALL

## Same thing without a password
# %wheel ALL=(ALL:ALL) NOPASSWD: ALL

## Uncomment to allow members of group sudo to execute any command
# %sudo	ALL=(ALL:ALL) ALL

## Uncomment to allow any user to run sudo if they know the password
## of the user they are running the command as (root by default).
# Defaults targetpw  # Ask for the password of the target user
# ALL ALL=(ALL:ALL) ALL  # WARNING: only use this together with 'Defaults targetpw'

## Read drop-in files from /etc/sudoers.d
@includedir /etc/sudoers.d
EOF
clear
echo "Make a password for root"
passwd
pacman -Sy archlinux-keyring archlinuxarm-keyring archlinux32-keyring parabola-keyring
pacman -Syu
cat > /etc/pacman.conf <<EOF
#
# /etc/pacman.conf
#
# See the pacman.conf(5) manpage for option and repository directives

#
# GENERAL OPTIONS
#
[options]
# The following paths are commented out with their default values listed.
# If you wish to use different paths, uncomment and update the paths.
#RootDir     = /
#DBPath      = /var/lib/pacman/
#CacheDir    = /var/cache/pacman/pkg/
#LogFile     = /var/log/pacman.log
#GPGDir      = /etc/pacman.d/gnupg/
#HookDir     = /etc/pacman.d/hooks/
HoldPkg     = pacman glibc
#XferCommand = /usr/bin/curl -L -C - -f -o %o %u
#XferCommand = /usr/bin/wget --passive-ftp -c -O %o %u
#CleanMethod = KeepInstalled
Architecture = x86_64

# Pacman won't upgrade packages listed in IgnorePkg and members of IgnoreGroup
#IgnorePkg   =
#IgnoreGroup =

#NoUpgrade   =
#NoExtract   =

# Misc options
#UseSyslog
ILoveCandy
Color
#NoProgressBar
CheckSpace
#VerbosePkgLists
#ParallelDownloads = 5

# By default, pacman accepts packages signed by keys that its local keyring
# trusts (see pacman-key and its man page), as well as unsigned packages.
SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional
#RemoteFileSigLevel = Required

# NOTE: You must run `pacman-key --init` before first using pacman; the local
# keyring can then be populated with the keys of all trusted packagers with:
#   `pacman-key --populate archlinux parabola`.

#
# REPOSITORIES
#   - can be defined here or included from another file
#   - pacman will search repositories in the order defined here
#   - local/custom mirrors can be added here or in separate files
#   - repositories listed first will take precedence when packages
#     have identical names, regardless of version number
#   - URLs will have $repo replaced by the name of the current repo
#   - URLs will have $arch replaced by the name of the architecture
#
# Repository entries are of the format:
#       [repo-name]
#       Server = ServerName
#       Include = IncludePath
#
# The header [repo-name] is crucial - it must be present and
# uncommented to enable the repo.
#
# Some repositories are disabled by default. To enable them, un-comment the
# repo name header (e.g. '[nonprism]') and the following 'Include' line.
# You can add preferred servers for each repo between the header and "Include" line,
# according to the format in /etc/pacman.d/mirrorlist,
# and those will be preferred over the standard mirrors for that repo.
#
# The order in which these entries appear in this file is critical.
# Much of the Parabola magic that supports advanced features such as
# multiple init-systems and multiple layers of freedom and privacy,
# depends on the order in which these repos are defined.
# Moving or adding repos out of the expected order can make your system insane.

# Notes on special repositories:
#
# Non-prism is a repository for enhanced privacy, beyond the FSDG requirements.
# It contains specially patched versions of certain software from the standard repos,
# that are known to include privacy-sensative features that some people may want to use,
# but that others may consider to be undesirable anti-features.
# For more info see: https://wiki.parabola.nu/Nonprism
#
# The non-systemd repository contains packages that are important and relevant only to
# Parabola systems using an init-system other than systemd.
# Parabola systems using systemd SHOULD NOT have [nonsystemd] enabled.
# Parabola systems using any other init-system SHOULD have [nonsystemd] enabled.
#
# The kernels repository contains additional special kernels for particular use-cases,
# such as maximal security hardening and real-time systems.
#
# The PCR (Parabola Community Repository) contains additional packages,
# most often requested by Parabola users, that are not considered to be
# part of the standard Parabola/Arch system, but are nonetheless useful or fun.
#
# Multi-lib repositories allow 32-bit applications to run on x86_64 systems.
#
# The Parabola system also supports custom, user-defined, repositories;
# but be aware that the Parabola team can not recommend nor support their use.
# The Parabola team can only support the use of software that is published by Parabola.
# The use of third-party software is discouraged with a "use at your own risk" warning.
# These may be community-maintained or maintained privately by the local user or sysadmin.
# They may be hosted on the internet, on the local network, or only on the local computer.
# An example of a custom package repository is given below
# in the "User-defined repos" section
# See the pacman manpage for details on creating your own repositories.


###########################
# Parabola standard repos #
###########################

#[nonprism-testing]
#Include = /etc/pacman.d/mirrorlist

[nonprism]
Include = /etc/pacman.d/mirrorlist

#[nonsystemd-testing]
#Include = /etc/pacman.d/mirrorlist

[nonsystemd]
Include = /etc/pacman.d/mirrorlist

#[libre-testing]
#Include = /etc/pacman.d/mirrorlist

[libre]
Include = /etc/pacman.d/mirrorlist

#[kernels-testing]
#Include = /etc/pacman.d/mirrorlist

#[kernels]
#Include = /etc/pacman.d/mirrorlist


#######################
# Arch standard repos #
#######################

#[testing]
#Include = /etc/pacman.d/mirrorlist

[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

#[community-testing]
#Include = /etc/pacman.d/mirrorlist

[community]
Include = /etc/pacman.d/mirrorlist


######################
# Supplemental repos #
######################

#[pcr-testing]
#Include = /etc/pacman.d/mirrorlist

[pcr]
Include = /etc/pacman.d/mirrorlist


############################
# Cross-architecture repos #
############################

#[nonprism-multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[nonprism-multilib]
#Include = /etc/pacman.d/mirrorlist

#[nonsystemd-multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[nonsystemd-multilib]
#Include = /etc/pacman.d/mirrorlist

#[libre-multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[libre-multilib]
#Include = /etc/pacman.d/mirrorlist

#[multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[multilib]
#Include = /etc/pacman.d/mirrorlist

#[pcr-multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[pcr-multilib]
#Include = /etc/pacman.d/mirrorlist


######################
# User-defined repos #
######################

#[custom]
#SigLevel = Optional TrustAll
#Server = file:///home/custompkgs


##############
# Over-rides #
##############

#Include = /etc/pacman.d/*.conf
EOF
clear
echo "Your installation is done!!"
echo "reboot please because idk how to do it"
exit
EOF
chmod +x /mnt/stage2.sh
arch-chroot /mnt /stage2.sh
