DISK1="$1"

# Zap disks data structures to prepare for installation
blkdiscard -f $DISK1

# When configuring boot.loader.grub.mirroredBoots.*.devices use the shorter UUID
# rather than the large one.
# This -> B977-418E
# Not this -> 9081665241299708278
# The larger UUID is the ZFS Mirror's UUID, which will change dependant on what
# disk is used to boot.

# Creating partitions
# This creates the ESP / Boot partition at the beginning of
# the drive but numbered as the third partition:
sgdisk -n3:1M:+512M -t3:EF00 $DISK1

# This create the storage partition numbered as the
# first partition:
sgdisk -n1:0:0 -t1:BF01 $DISK1

sync
udevadm settle

# Some flags to consider
#
# Disable ZFS automatic mounting:
#   -O mountpoint=none
#
# Disable writing access time:
#   -O atime=off
#
# Use 4K sectors on the drive, otherwise you can get really
# bad performance:
#   -o ashift=12
#
# This is more or less required for certain things to
# not break:
#   -O acltype=posixacl
#
# To improve performance of certain extended attributes:
#   -O xattr=sa
#
# To enable file system compression:
#   -O compression=lz4
#
# To enable encryption:
#   -O encryption=aes-256-gcm -O keyformat=passphrase

# Then we create the pool which is mirrored over both drives
# and encrypted with ZFS native encryption (if you added
# those flags):
zpool create -f -O mountpoint=none -O atime=off -o ashift=12 -O acltype=posixacl -O xattr=sa -O compression=lz4 zroot $DISK1-part1

# Create ZFS datasets
zfs create -o mountpoint=legacy zroot/root      # For /
zfs create -o mountpoint=legacy zroot/root/home # For /home
zfs create -o mountpoint=legacy zroot/root/nix  # For /nix

# Create ESP partiions
mkfs.vfat $DISK1-part3

# Mount new ZFS pool
mount -t zfs zroot/root /mnt

# Create directories to mount file systems on
mkdir /mnt/{nix,home,boot}

# Mount the rest of the ZFS file systems
mount -t zfs zroot/root/nix /mnt/nix
mount -t zfs zroot/root/home /mnt/home

# Mount both of the ESP's
mount $DISK1-part3 /mnt/boot

# Generate NixOS Config in /mnt
nixos-generate-config --root /mnt

