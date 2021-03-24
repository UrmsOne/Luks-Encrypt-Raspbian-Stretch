#!/bin/sh

#mkdir /tmp/boot
#mount /dev/mmcblk0p1 /tmp/boot/
#/tmp/boot/install/4.luks_open.sh
echo "123456" > /boot/cryptpasswd.txt
cryptsetup luksOpen --key-file /boot/cryptpasswd.txt /dev/mmcblk0p2 sdcard
exit
