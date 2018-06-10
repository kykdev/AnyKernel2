# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=AK2 version of no-verity-opt-encrypt by kykint
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=starlte
device.name2=star2lte
device.name3=
device.name4=
device.name5=
'; } # end properties

# shell variables
block=/dev/block/platform/11120000.ufs/by-name/BOOT;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# fstab.samsungexynos9810
patch_fstab fstab.samsungexynos9810 /system ext4 flags ",verify" "";
patch_fstab fstab.samsungexynos9810 /cache ext4 flags ",verify" "";
patch_fstab fstab.samsungexynos9810 /data ext4 flags ",verify" "";
patch_fstab fstab.samsungexynos9810 /system ext4 flags ",support_scfs" "";
patch_fstab fstab.samsungexynos9810 /cache ext4 flags ",support_scfs" "";
patch_fstab fstab.samsungexynos9810 /data ext4 flags ",support_scfs" "";
patch_fstab fstab.samsungexynos9810 /data ext4 flags "forceencrypt=" "encryptable=";
patch_fstab fstab.samsungexynos9810 /data ext4 flags "forcefdeorfbe=" "encryptable=";

# default.prop
patch_prop default.prop ro.config.dmverity false;

# end ramdisk changes

# patch dtb
$bin/dtb_patch $split_img/boot.img-dtb;

write_boot;

## end install

