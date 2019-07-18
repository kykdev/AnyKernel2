# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=cpufreq limiter for hero by kykint
do.devicecheck=0
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
} # end properties

# shell variables
block=/dev/block/platform/155a0000.ufs/by-name/BOOT;
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

insert_file init.rc "Limit cpufreq by kykint" after "chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/io_is_busy" cpufreq_limit
replace_string fstab.samsungexynos8890 encryptable "ro,errors=panic,noload        " "ro,noatime,errors=panic,noload"
replace_string fstab.samsungexynos8890.fwup encryptable "ro,errors=panic,noload        " "ro,noatime,errors=panic,noload"
replace_string fstab.samsungexynos8890 encryptable "wait,verify" wait
replace_string fstab.samsungexynos8890.fwup encryptable "wait,verify" wait
replace_string fstab.samsungexynos8890 encryptable forceencrypt encryptable
replace_string fstab.samsungexynos8890.fwup encryptable forceencrypt encryptable

# end ramdisk changes

write_boot;

## end install

