#!/bin/sh

set -u
set -e

# Add a console on tty1
#if [ -e ${TARGET_DIR}/etc/inittab ]; then
#    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
#	sed -i '/GENERIC_SERIAL/a\
#tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
#fi

TARGETDIR=$1
BR_ROOT=$PWD

mkdir -p $TARGETDIR/mnt/
mkdir -p $TARGETDIR/mnt/boot
mkdir -p $TARGETDIR/mnt/data

if ! grep -qE '^/dev/mmcblk0p1' "${TARGETDIR}/etc/fstab"; then
			echo "Adding mount points to fstab"
			cat << __EOF__ >> "${TARGETDIR}/etc/fstab"

/dev/mmcblk0p1 /mnt/boot auto defaults 0 0
/dev/mmcblk0p2 /mnt/data auto defaults 0 0

__EOF__

fi
