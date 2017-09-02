# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=Knoxblower Kernel alpha
do.devicecheck=0
do.modules=0
do.system=1
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
} # end properties

block=/dev/block/platform/155a0000.ufs/by-name/BOOT;
is_slot_device=0;

. /tmp/anykernel/tools/ak2-core.sh;

dump_boot;
write_boot;

