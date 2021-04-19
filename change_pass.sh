#https://github.com/johnshearing/MyEtherWalletOffline/blob/master/Air-Gap_Setup.md#setup-luks-full-disk-encryption
#https://robpol86.com/raspberry_pi_luks.html
#https://www.howtoforge.com/automatically-unlock-luks-encrypted-drives-with-a-keyfile

# step:
# 1. modify resize2fs, replace loadkeyfile.sh of startup_check 
# 2. modify "/etc/scrypttab", replace loadkeyfile.sh of startup_check
# 3. run change_pass.sh, rebuild initramfs

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

apt-get install busybox cryptsetup initramfs-tools -y
apt-get install expect --no-install-recommends -y
cp /boot/install/initramfs-rebuild /etc/kernel/postinst.d/initramfs-rebuild
cp /boot/install/resize2fs /etc/initramfs-tools/hooks/resize2fs
chmod +x /etc/kernel/postinst.d/initramfs-rebuild
chmod +x /etc/initramfs-tools/hooks/resize2fs

#Get UUID of /dev/mmcblk0p2
#blkid | sed -n '/dev\/mmcblk0p2/s/.*\ UUID=\"\([^\"]*\)\".*/\1/p'
#change fstab from PARTUUID=XXXXXXXX-XX to the result of the command


# dd if=/dev/urandom of=/root/keyfile bs=1024 count=4
cp /boot/install/startup_check /lib/cryptsetup/scripts/

#sudo -E CRYPTSETUP=y mkinitramfs -o /boot/initramfs.gz
mkinitramfs -o /boot/initramfs.gz

lsinitramfs /boot/initramfs.gz | grep -P "sbin/(cryptsetup|resize2fs|fdisk|dumpe2fs|expect)"
#Make sure you see sbin/resize2fs, sbin/cryptsetup, and sbin/fdisk in the output.

echo "Done. Reboot with: sudo reboot"
#reboot