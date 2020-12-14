#
# Copyright (C) 2016 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include build/make/target/board/BoardConfigMainlineCommon.mk

TARGET_BOARD_PLATFORM := lito
USES_DEVICE_GOOGLE_REDBULL := true

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a76

BUILD_BROKEN_DUP_RULES := true
BOARD_KERNEL_CMDLINE += console=ttyMSM0,115200n8 androidboot.console=ttyMSM0 printk.devkmsg=on
BOARD_KERNEL_CMDLINE += msm_rtb.filter=0x237
BOARD_KERNEL_CMDLINE += ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += service_locator.enable=1
BOARD_KERNEL_CMDLINE += androidboot.memcg=1 cgroup.memory=nokmem
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1 # STOPSHIP b/113233473
BOARD_KERNEL_CMDLINE += usbcore.autosuspend=7
BOARD_KERNEL_CMDLINE += androidboot.usbcontroller=a600000.dwc3 swiotlb=2048
BOARD_KERNEL_CMDLINE += androidboot.boot_devices=soc/1d84000.ufshc
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += snd_soc_cs35l41_i2c.async_probe=1
BOARD_KERNEL_CMDLINE += i2c_qcom_geni.async_probe=1
BOARD_KERNEL_CMDLINE += st21nfc.async_probe=1
BOARD_KERNEL_CMDLINE += spmi_pmic_arb.async_probe=1
BOARD_KERNEL_CMDLINE += ufs_qcom.async_probe=1

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096

BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_BOOT_HEADER_VERSION := 3
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

BOARD_DTBOIMG_PARTITION_SIZE := 16777216

TARGET_NO_KERNEL := false
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true
ifneq ($(PRODUCT_BUILD_VENDOR_BOOT_IMAGE),false)
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
endif

BOARD_USES_METADATA_PARTITION := true

AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    vendor_boot \
    system \
    vbmeta \
    dtbo \
    product \
    vbmeta_system \
    system_ext

# Partitions (listed in the file) to be wiped under recovery.
TARGET_RECOVERY_WIPE := device/google/redbull/recovery.wipe
TARGET_RECOVERY_FSTAB := device/google/redbull/fstab.hardware
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_UI_LIB := \
    librecovery_ui_pixel \
    libfstab

# Enable chain partition for system.
BOARD_AVB_VBMETA_SYSTEM := system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

# product.img
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4

# userdata.img
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USERDATAIMAGE_PARTITION_SIZE := 10737418240
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# persist.img
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4

# boot.img
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x06000000

# vendor_boot.img
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 0x06000000

# Allow LZ4 compression
BOARD_RAMDISK_USE_LZ4 := true

# Specify BOOT_KERNEL_MODULES
#
# modules for first stage in vendor_boot.img, remainder goes to vendor.img.
# This list is a superset of all the possible modules required, and is
# filtered and ordered as per the supplied kernel's modules.load file.
# Any modules that do not exist will be silently dropped.  This is required
# because some kernel configurations may have extra debug or test modules,
# make sure any required to be loaded during first stage init are listed.
BOOT_KERNEL_MODULES := \
	msm_ipc_logging.ko \
	qtee_shm_bridge.ko \
	qcom_hwspinlock.ko \
	smem.ko \
	msm_minidump.ko \
	watchdog_v2.ko \
	early_random.ko \
	qcom-pdc.ko \
	cmd-db.ko \
	qcom_rpmh.ko \
	phy-qcom-ufs.ko \
	phy-qcom-ufs-qrbtc-sdm845.ko \
	phy-qcom-ufs-qmp-v4.ko \
	phy-qcom-ufs-qmp-v4-lito.ko \
	phy-qcom-ufs-qmp-v3-660.ko \
	phy-qcom-ufs-qmp-v3.ko \
	pinctrl-msm.ko \
	pinctrl-lito.ko \
	qcom-spmi-wled.ko \
	msm_bus.ko \
	clk-qcom.ko \
	clk-aop-qmp.ko \
	clk-rpmh.ko \
	gcc-lito.ko \
	clk-spmi-pmic-div.ko \
	qrtr.ko \
	qmi_helpers.ko \
	secure_buffer.ko \
	heap_mem_ext_v01.ko \
	subsystem_notif.ko \
	ramdump.ko \
	msm_memshare.ko \
	msm_bus_dbg_rpmh.ko \
	msm_bus_rpmh.ko \
	rpmh-regulator.ko \
	qcom-geni-se.ko \
	msm_geni_serial.ko \
	msm_dma_iommu_mapping.ko \
	arm-smmu-debug.ko \
	iommu-logger.ko \
	arm-smmu.ko \
	ufshcd-core.ko \
	ufshcd-pltfrm.ko \
	ufs_qcom.ko \
	spi-geni-qcom.ko \
	i2c-qcom-geni.ko \
	ion-alloc.ko \
	msm_rtb.ko \
	pinctrl-spmi-gpio.ko \
	pinctrl-spmi-mpp.ko \
	pwm-qti-lpg.ko \
	debugcc-lito.ko \
	dispcc-lito.ko \
	gpucc-lito.ko \
	npucc-lito.ko \
	videocc-lito.ko \
	virt-dma.ko \
	gpi.ko \
	msm_scm.ko \
	mdt_loader.ko \
	smem_state.ko \
	smp2p.ko \
	qcom_ipcc.ko \
	llcc-slice.ko \
	llcc-lito.ko \
	core_hang_detect.ko \
	gladiator_hang_detect.ko \
	minidump_log.ko \
	memory_dump_v2.ko \
	dcc_v2.ko \
	service-locator.ko \
	service-notifier.ko \
	subsystem-restart.ko \
	peripheral-loader.ko \
	subsys-pil-tz.ko \
	cdsp-loader.ko \
	qseecom.ko \
	smcinvoke.ko \
	microdump_collector.ko \
	eud.ko \
	qcom_socinfo.ko \
	fsa4480-i2c.ko \
	rpmsg_core.ko \
	qcom_glink_native.ko \
	qcom_glink_smem.ko \
	qcom_glink_spss.ko \
	glink_probe.ko \
	glink_pkt.ko \
	smp2p_sleepstate.ko \
	event_timer.ko \
	lpm-stats.ko \
	msm_pm.ko \
	rpmh_master_stat.ko \
	system_pm.ko \
	rpm_stats.ko \
	ddr_stats.ko \
	cdsprm.ko \
	msm_icnss.ko \
	modemsmem.ko \
	qpnp-amoled-regulator.ko \
	refgen.ko \
	slg51000-regulator.ko \
	tps-regulator.ko \
	msm_rng.ko \
	adsprpc_compat.ko \
	adsprpc.ko \
	fastcvpd.ko \
	rdbg.ko \
	qpnp-power-on.ko \
	msm-poweroff.ko \
	usb_f_diag.ko \
	diagchar.ko \
	governor_bw_vbif.ko \
	governor_gpubw_mon.ko \
	governor_msm_adreno_tz.ko \
	msm_adreno.ko \
	regmap-spmi.ko \
	google-bms.ko \
	at24.ko \
	hdcp_qseecom.ko \
	msm_hdcp.ko \
	citadel-spi.ko \
	qcom-i2c-pmic.ko \
	qcom-spmi-pmic.ko \
	st21nfc.ko \
	st54j_se.ko \
	qpnp-revid.ko \
	devfreq_qcom_fw.ko \
	adc_tm.ko \
	msm_sps.ko \
	qce50.ko \
	qcedev-module.ko \
	qcrypto.ko \
	spmi-pmic-arb.ko \
	cnss_utils.ko \
	cnss_prealloc.ko \
	cnss_nl.ko \
	msm_sharedmem.ko \
	phy-generic.ko \
	phy-msm-ssusb-qmp.ko \
	phy-msm-snps-hs.ko \
	xhci-plat-hcd.ko \
	rndis.ko \
	usb_f_cdev.ko \
	usb_f_ccid.ko \
	dwc3.ko \
	usb-dwc3-msm.ko \
	usb_f_qdss.ko \
	msm_gsi.ko \
	ipa3.ko \
	usb_f_gsi.ko \
	usb_f_mtp.ko \
	usb_f_ptp.ko \
	roles.ko \
	tcpm.ko \
	logbuffer.ko \
	pmic-voter.ko \
	qpnp_pdphy.ko \
	dwc3-haps.ko \
	dwc3-of-simple.ko \
	dwc3-qcom.ko \
	touchscreen_tbn.ko \
	vd6281_module.ko \
	fpc1020_platform_tee.ko \
	rtc-pm8xxx.ko \
	i2c-qcom-geni.ko \
	devfreq_devbw.ko \
	msm_npu.ko \
	qpnp-battery.ko \
	of_batterydata.ko \
	qpnp-smb5-charger.ko \
	qpnp-qgauge.ko \
	sm7250_bms.ko \
	google_charger.ko \
	google-battery.ko \
	overheat_mitigation.ko \
	p9221_charger.ko \
	qti_qmi_sensor.ko \
	bcl_pmic5.ko \
	bcl_soc.ko \
	qmi_cdev.ko \
	lmh_dbg.ko \
	msm_lmh_dcvs.ko \
	regulator_aop_cdev.ko \
	cpu_isolate.ko \
	lmh_cpu_vdd_cdev.ko \
	qcom-spmi-temp-alarm.ko \
	thermal-tsens.ko \
	slimbus.ko \
	bluetooth_power.ko \
	qcom_edac.ko \
	qcom-cpufreq-hw.ko \
	leds-qpnp-flash-common.ko \
	leds-qpnp-flash-v2.ko \
	of_slimbus.ko \
	tz_log.ko \
	google_wlan_mac.ko \
	msm_ext_display.ko \
	msm_qmp.ko \
	governor_bw_hwmon.ko \
	bimc-bwmon.ko \
	governor_memlat.ko \
	arm-memlat-mon.ko \
	governor_cdsp_l3.ko \
	qcom-vadc-common.ko \
	qcom-spmi-adc5.ko \
	pac193x.ko \
	qcom_llcc_pmu.ko \
	nvmem_qfprom.ko \
	qcom-spmi-sdam.ko \
	slim_msm_ngd.ko \
	rpmsg_char.ko \
	rmnet.ko \
	usb-audio-qmi.ko \
	msm-vidc.ko \
	ebtables.ko \
	ebtable_broute.ko \
	sctp.ko \
	sctp_diag.ko \
	qrtr-smd.ko \
	msm_drm.ko \

# system_ext.img
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4

BOARD_FLASH_BLOCK_SIZE := 131072

BOARD_ROOT_EXTRA_SYMLINKS := /vendor/lib/dsp:/dsp
BOARD_ROOT_EXTRA_SYMLINKS += /mnt/vendor/persist:/persist

include device/google/redbull-sepolicy/redbull-sepolicy.mk

QCOM_BOARD_PLATFORMS += lito
QC_PROP_ROOT := vendor/qcom/sm7250/proprietary
QC_PROP_PATH := $(QC_PROP_ROOT)
BOARD_HAVE_BLUETOOTH_QCOM := true
BOARD_HAVE_QCOM_FM := false
TARGET_USE_QTI_BT_SAR := true
TARGET_USE_QTI_BT_CHANNEL_AVOIDANCE := true
BOARD_USES_COMMON_BLUETOOTH_HAL := true

# Camera
TARGET_USES_AOSP := true
BOARD_QTI_CAMERA_32BIT_ONLY := false
CAMERA_DAEMON_NOT_PRESENT := true
TARGET_USES_ION := true

# GPS
TARGET_NO_RPC := true
TARGET_USES_HARDWARE_QCOM_GPS := false
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := default
BOARD_VENDOR_QCOM_LOC_PDK_FEATURE_SET := true

# RenderScript
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so

# Sensors
TARGET_SUPPORT_DIRECT_REPORT := true

# CHRE
CHRE_DAEMON_ENABLED := true
CHRE_DAEMON_LPMA_ENABLED := true
CHRE_DAEMON_LOAD_INTO_SENSORSPD := true

# wlan
BOARD_WLAN_DEVICE := qcwcn
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER := NL80211
WIFI_DRIVER_DEFAULT := qca_cld3
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_HIDL_FEATURE_AWARE := true
WIFI_HIDL_FEATURE_DUAL_INTERFACE:= true
WIFI_FEATURE_WIFI_EXT_HAL := true
WIFI_FEATURE_IMU_DETECTION := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true

# Audio
BOARD_USES_ALSA_AUDIO := true
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true
AUDIO_FEATURE_ENABLED_SND_MONITOR := true
AUDIO_FEATURE_ENABLED_USB_TUNNEL := true
BOARD_SUPPORTS_SOUND_TRIGGER := true
AUDIO_FEATURE_FLICKER_SENSOR_INPUT := true
#SOUND_TRIGGER_FEATURE_LPMA_ENABLED := true
AUDIO_FEATURE_ENABLED_MAXX_AUDIO := true
AUDIO_FEATURE_ENABLED_AUDIO_THERMAL_LISTENER := true
AUDIO_FEATURE_ENABLED_24BITS_CAMCORDER := true
AUDIO_FEATURE_ENABLED_AUDIO_ZOOM := true
AUDIO_FEATURE_ENABLED_INSTANCE_ID := true
#Cirrus cs35l41 speaker amp
AUDIO_FEATURE_ENABLED_CS35L41 := true
AUDIO_FEATURE_ENABLED_CS35L41_CALIBRATION_TOOL := true
AUDIO_FEATURE_ENABLED_SVA_MULTI_STAGE := true
AUDIO_FEATURE_QSSI_COMPLIANCE := true

# Audio hal flag
TARGET_USES_HARDWARE_QCOM_AUDIO := true
TARGET_USES_HARDWARE_QCOM_AUDIO_PLATFORM_8974 := true
TARGET_USES_HARDWARE_QCOM_AUDIO_POSTPROC := true
TARGET_USES_HARDWARE_QCOM_AUDIO_VOLUME_LISTENER := true
TARGET_USES_HARDWARE_QCOM_AUDIO_GET_MMAP_DATA_FD := true
TARGET_USES_HARDWARE_QCOM_AUDIO_APP_TYPE_CFG := true
TARGET_USES_HARDWARE_QCOM_AUDIO_ACDB_INIT_V2_CVD := true
TARGET_USES_HARDWARE_QCOM_AUDIO_MAX_TARGET_SPECIFIC_CHANNEL_CNT := "4"
TARGET_USES_HARDWARE_QCOM_AUDIO_INCALL_MUSIC_ENABLED := true
TARGET_USES_HARDWARE_QCOM_AUDIO_MULTIPLE_HW_VARIANTS_ENABLED := true
TARGET_USES_HARDWARE_QCOM_AUDIO_INCALL_STEREO_CAPTURE_ENABLED := true

# Graphics
TARGET_USES_GRALLOC1 := true
TARGET_USES_HWC2 := true

# Display
TARGET_USES_DISPLAY_RENDER_INTENTS := true
TARGET_USES_COLOR_METADATA := true
TARGET_USES_DRM_PP := true
TARGET_HAS_WIDE_COLOR_DISPLAY := true
TARGET_HAS_HDR_DISPLAY := true

# Vendor Interface Manifest
DEVICE_MANIFEST_FILE := device/google/redbull/manifest.xml
DEVICE_MATRIX_FILE := device/google/redbull/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := device/google/redbull/device_framework_matrix.xml
DEVICE_FRAMEWORK_MANIFEST_FILE := device/google/redbull/framework_manifest.xml

# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

# dynamic partition
BOARD_SUPER_PARTITION_SIZE := 9755951104
BOARD_SUPER_PARTITION_GROUPS := google_dynamic_partitions
BOARD_GOOGLE_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    vendor \
    product \
    system_ext

#BOARD_GOOGLE_DYNAMIC_PARTITIONS_SIZE is set to BOARD_SUPER_PARTITION_SIZE / 2 - 4MB
BOARD_GOOGLE_DYNAMIC_PARTITIONS_SIZE := 4873781248

# Set error limit to BOARD_SUPER_PARTITON_SIZE - 500MB
BOARD_SUPER_PARTITION_ERROR_LIMIT := 9231663104

BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true

-include device/google/redbull/soong/pixel_soong_config.mk

# List of modules that should not load automatically
PRODUCT_COPY_FILES += \
    device/google/redbull/modules.blocklist:$(TARGET_COPY_OUT_VENDOR)/lib/modules/modules.blocklist \
    device/google/redbull/init.insmod.charger.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/init.insmod.charger.cfg \

# TARGET_BOOLOADER_BOARD_NAME sensitive common boilerplate

TARGET_BOARD_NAME_DIR := device/google/$(TARGET_BOOTLOADER_BOARD_NAME)
-include $(TARGET_BOARD_NAME_DIR:%/=%)-sepolicy/$(TARGET_BOOTLOADER_BOARD_NAME)-sepolicy.mk

TARGET_BOARD_INFO_FILE := $(TARGET_BOARD_NAME_DIR)/board-info.txt
TARGET_BOARD_COMMON_PATH := $(TARGET_BOARD_NAME_DIR)/sm7250

# Common kernel file handling
TARGET_KERNEL_DIR := $(TARGET_BOARD_NAME_DIR:%/=%)-kernel

# DTBO partition definitions
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
    BOARD_PREBUILT_DTBOIMAGE := $(TARGET_KERNEL_DIR)/dtbo.img
else
    BOARD_PREBUILT_DTBOIMAGE := $(TARGET_KERNEL_DIR)/vintf/dtbo.img
endif
TARGET_FS_CONFIG_GEN := $(TARGET_BOARD_NAME_DIR)/config.fs

# Kernel modules
ifeq (,$(filter-out $(TARGET_BOOTLOADER_BOARD_NAME)_kasan, $(TARGET_PRODUCT)))
    KERNEL_MODULE_DIR := $(TARGET_KERNEL_DIR)/kasan
else ifeq (,$(filter-out $(TARGET_BOOTLOADER_BOARD_NAME)_kernel_debug_memory, $(TARGET_PRODUCT)))
    KERNEL_MODULE_DIR := $(TARGET_KERNEL_DIR)/debug_memory
else ifeq (,$(filter-out $(TARGET_BOOTLOADER_BOARD_NAME)_kernel_debug_locking, $(TARGET_PRODUCT)))
    KERNEL_MODULE_DIR := $(TARGET_KERNEL_DIR)/debug_locking
else ifeq (,$(filter-out $(TARGET_BOOTLOADER_BOARD_NAME)_kernel_debug_hang, $(TARGET_PRODUCT)))
    KERNEL_MODULE_DIR := $(TARGET_KERNEL_DIR)/debug_hang
else ifeq (,$(filter-out $(TARGET_BOOTLOADER_BOARD_NAME)_kernel_debug_api, $(TARGET_PRODUCT)))
    KERNEL_MODULE_DIR := $(TARGET_KERNEL_DIR)/debug_api
else
    ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
        KERNEL_MODULE_DIR := $(TARGET_KERNEL_DIR)
    else
        KERNEL_MODULE_DIR := $(TARGET_KERNEL_DIR)/vintf
    endif
endif

# Copy kheaders.ko to vendor/lib/modules for VTS test
BOARD_VENDOR_KERNEL_MODULES += $(KERNEL_MODULE_DIR)/kheaders.ko

KERNEL_MODULES := $(wildcard $(KERNEL_MODULE_DIR)/*.ko)
KERNEL_MODULES_LOAD := $(strip $(shell cat $(firstword $(wildcard \
        $(KERNEL_MODULE_DIR)/modules.load \
        $(if $(filter userdebug eng,$(TARGET_BUILD_VARIANT)), \
            $(TARGET_KERNEL_DIR)/vintf/modules.load,) \
        $(TARGET_KERNEL_DIR)/modules.load))))

# DTB
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_MODULE_DIR)

ifeq (,$(BOOT_KERNEL_MODULES))
    BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(KERNEL_MODULES)
    BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(KERNEL_MODULES_LOAD)
else
    #
    # BEWARE: This is a tuning exercise to get right, splitting between
    # boot essential drivers, fastboot/recovery drivers, and the remainder
    # used by Android, but not the blocklist (device specific drivers not
    # common between platforms or drivers that must not be autoloaded) which
    # are loaded later.
    #
    # BOOT_KERNEL_MODULES     - Modules loaded in first stage init.
    # RECOVERY_KERNEL_MODULES - Additional modules loaded in recovery/fastbootd
    #                           or in second stage init.
    # file: modules.blocklist - Not autoloaded. loaded on demand product or HAL.
    # Remainder               - In second stage init, but after recovery set;
    #                           minus the blocklist.
    #
    BOOT_KERNEL_MODULES_FILTER := $(foreach m,$(BOOT_KERNEL_MODULES),%/$(m))
    ifneq (,$(RECOVERY_KERNEL_MODULES))
        RECOVERY_KERNEL_MODULES_FILTER := \
            $(foreach m,$(RECOVERY_KERNEL_MODULES),%/$(m))
    endif
    BOARD_VENDOR_RAMDISK_KERNEL_MODULES += \
            $(filter $(BOOT_KERNEL_MODULES_FILTER) \
                     $(RECOVERY_KERNEL_MODULES_FILTER),$(KERNEL_MODULES))

    # ALL modules land in /vendor/lib/modules so they could be rmmod/insmod'd,
    # and modules.list actually limits us to the ones we intend to load.
    BOARD_VENDOR_KERNEL_MODULES := $(KERNEL_MODULES)
    # To limit /vendor/lib/modules to just the ones loaded, use:
    #
    #   BOARD_VENDOR_KERNEL_MODULES := $(filter-out \
    #       $(BOOT_KERNEL_MODULES_FILTER),$(KERNEL_MODULES))

    # Group set of /vendor/lib/modules loading order to recovery modules first,
    # then remainder, subtracting both recovery and boot modules.
    BOARD_VENDOR_KERNEL_MODULES_LOAD := \
            $(filter-out $(BOOT_KERNEL_MODULES_FILTER), \
            $(filter $(RECOVERY_KERNEL_MODULES_FILTER),$(KERNEL_MODULES_LOAD)))
    BOARD_VENDOR_KERNEL_MODULES_LOAD += \
            $(filter-out $(BOOT_KERNEL_MODULES_FILTER) \
                 $(RECOVERY_KERNEL_MODULES_FILTER),$(KERNEL_MODULES_LOAD))

    # NB: Load order governed by modules.load and not by $(BOOT_KERNEL_MODULES)
    BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := \
            $(filter $(BOOT_KERNEL_MODULES_FILTER),$(KERNEL_MODULES_LOAD))

    ifneq (,$(RECOVERY_KERNEL_MODULES_FILTER))
        # Group set of /vendor/lib/modules loading order to boot modules first,
        # then remainder of recovery modules.
        BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := \
            $(filter $(BOOT_KERNEL_MODULES_FILTER),$(KERNEL_MODULES_LOAD))
        BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD += \
            $(filter-out $(BOOT_KERNEL_MODULES_FILTER), \
            $(filter $(RECOVERY_KERNEL_MODULES_FILTER),$(KERNEL_MODULES_LOAD)))
    endif
endif

# Testing related defines
BOARD_PERFSETUP_SCRIPT := platform_testing/scripts/perf-setup/b5r3-setup.sh
