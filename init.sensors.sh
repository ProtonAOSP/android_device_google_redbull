#! /vendor/bin/sh

version=`grep -ao "OEM_IMAGE_VERSION_STRING[ -~]*" \
              /vendor/firmware/adsp.b04 | \
         sed -e s/OEM_IMAGE_VERSION_STRING=ADSP.version.// -e s/\(.*\).//`
setprop vendor.sys.adsp.firmware.version "$version"

if [ -f /sys/devices/soc0/g_platform_version ]; then
  B5_LUNCHBOX_PLATFORM_VERSION="655360"
  B5_PVT_PLATFORM_VERSION="655390"
  platform_version=`cat /sys/devices/soc0/g_platform_version`
  if [ $platform_version -gt $B5_LUNCHBOX_PLATFORM_VERSION ]; then
    if [ $platform_version -lt $B5_PVT_PLATFORM_VERSION ]; then
      setprop vendor.sensor.proximity_fusion.enabled true
    fi
  fi
fi
