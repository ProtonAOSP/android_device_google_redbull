#! /vendor/bin/sh

#
# Publish CDT IMEI/MEID to properties
#
setprop vendor.modem.cdt.imei1 $(cat /proc/device-tree/chosen/cdt/cdb2/imei1)
setprop vendor.modem.cdt.imei2 $(cat /proc/device-tree/chosen/cdt/cdb2/imei2)
setprop vendor.modem.cdt.meid1 $(cat /proc/device-tree/chosen/cdt/cdb2/meid1)
setprop vendor.modem.cdt.meid2 $(cat /proc/device-tree/chosen/cdt/cdb2/meid2)