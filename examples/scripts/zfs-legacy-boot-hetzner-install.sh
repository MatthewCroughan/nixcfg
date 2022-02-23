set -e

DISK1=/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_17100545

# Zap disks data structures to prepare for installation
blkdiscard -f $DISK1

# Creating partitions
# This creates the storage partition numbered as the first partition:
sgdisk -n1:0:0 -t1:BF01 $DISK1

# This creates the legacy (BIOS) partition.
sgdisk -a1 -n2:34:2047 -t2:EF02 $DISK1

# Allow disk to settle
sync
udevadm settle

# Create the ZFS Pool
zpool create -f -O mountpoint=none -O atime=off -o ashift=12 -O acltype=posixacl -O xattr=sa -O compression=lz4 zroot $DISK1-part1

# Create ZFS datasets
zfs create -o mountpoint=legacy zroot/root      # For /
zfs create -o mountpoint=legacy zroot/root/home # For /home
zfs create -o mountpoint=legacy zroot/root/nix  # For /nix

# Mount new ZFS pool
mount -t zfs zroot/root /mnt

# Create directories to mount file systems on
mkdir /mnt/{nix,home}

# Mount the rest of the ZFS file systems
mount -t zfs zroot/root/nix /mnt/nix
mount -t zfs zroot/root/home /mnt/home

# Generate NixOS Config in /mnt
nixos-generate-config --root /mnt
