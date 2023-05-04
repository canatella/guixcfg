#!/bin/bash
set -euxo pipefail

export LANG=C.UTF-8
export DEBIAN_FRONTEND=noninteractive

SRC=$(dirname $0)/system
DST="/mnt"
CHR="chroot ${DST}"

/usr/sbin/debootstrap --arch amd64  --include=ca-certificates,debconf-utils bookworm "${DST}" http://ftp.be.debian.org/debian

for i in /dev /proc; do sudo mount --rbind $i /mnt$i; done

$CHR /usr/bin/debconf-set-selections < ${SRC}/debian/debconf-selections.txt

rm -f ${DST}/etc/apt/sources.list
install ${SRC}/apt/*.sources ${DST}/etc/apt/sources.list.d/

$CHR /usr/bin/apt update

$CHR /usr/bin/apt install --yes \
       locales \
       console-setup \
       btrfs-progs \
       grub-efi


$CHR /usr/bin/apt install teams

install ${SRC}/debian/fstab ${DST}/etc/fstab
$CHR mkdir -p /boot/efi /var/lib/docker /home
$CHR mount /boot/efi
$CHR mount /var/lib/docker
$CHR mount -t btrfs LABEL=home /home

$CHR /usr/bin/apt install --yes \
       task-english \
       task-french \
       task-gnome-desktop \
       task-ssh-server \
       snapper \
       strace \
       git \
       libyubikey-udev \
       borgbackup \
       mg \
       plymouth \
       plymouth-themes \
       firefox \
       zoom \
       intellij-idea-community \
       linux-image-generic \
       firmware-amd-graphics \
       firmware-linux \
       amd64-microcode \
       intel-microcode \
       guix \
       docker

install --mode 0644 ${SRC}/services/* ${DST}/etc/systemd/system/
install --mode 0755 ${SRC}/scripts/* ${DST}/usr/local/bin/

$CHR systemctl enable backup.timer

$CHR dpkg-reconfigure keyboard-configuration tzdata locales

# sensors
install ${SRC}/sensors/modules.conf ${DST}/etc/modules-load.d/ms-7C60-sensors.conf
install ${SRC}/sensors/MS-7C60.conf ${DST}/etc/sensors.d/

$CHR grub-install
$CHR update-grub

$CHR adduser dam
install ${SRC}/debian/sudoers ${DST}/etc/sudoers.d/dam

wget https://downloads.slack-edge.com/releases/linux/4.31.155/prod/x64/slack-desktop-4.31.155-amd64.deb -O ${DST}/home/dam/slack.deb
$CHR dpkg -i /home/dam/slack.deb
rm ${DST}/home/dam/slack.deb

wget https://installers.privateinternetaccess.com/download/pia-linux-3.3.1-06924.run -O ${DST}/home/dam/pia.run
$CHR chmod a+x /home/dam/pia.run
$CHR sudo -u dam /home/dam/pia.run
$CHR rm /home/dam/pia.run
$CHR chmod a-x /etc/systemd/system/piavpn.service


$CHR umount /home
$CHR umount /var/lib/docker
$CHR umount /boot/efi

for i in /sys /proc /dev; do sudo umount /mnt$i; done
