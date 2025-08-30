set -e

make -C ../buildroot

FNAMES="boot.json Image opensbi.bin rootfs.cpio rv32.dtb"

rm -rf fat_files.zip
(cd images && zip ../fat_files.zip $FNAMES)

# Ambitious: copy files directly to SD card
udisksctl mount -b /dev/mmcblk0p1 || true

for f in $FNAMES; do
	cp images/$f /media/$USER/BOOT/
done

umount /media/$USER/BOOT/ && sync
