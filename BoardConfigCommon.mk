#
# Copyright (C) 2020-2021 The LineageOS Project
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

COMMON_PATH := device/samsung/universal8825-common

BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Android Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flag 2

## Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

## Architecture (Secondary)
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

## Board
BOARD_VENDOR := samsung
TARGET_BOOTLOADER_BOARD_NAME := s5e8825
TARGET_BOARD_PLATFORM := universal8825
TARGET_SOC := exynos1280
TARGET_NO_BOOTLOADER := true

TARGET_BOARD_INFO_FILE := $(COMMON_PATH)/board-info.txt

# Kernel
BOARD_KERNEL_CMDLINE := androidboot.selinux=permissive bootconfig buildtime_bootconfig=enable loop.max_part=7
BOARD_CUSTOM_BOOTIMG := true
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_BASE := 0x10000000

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)

BOARD_RECOVERY_MKBOOTIMG_ARGS := --kernel_offset 0x00008000
BOARD_RECOVERY_MKBOOTIMG_ARGS += --ramdisk_offset 0x00000000
BOARD_RECOVERY_MKBOOTIMG_ARGS += --tags_offset 0x00000000
BOARD_RECOVERY_MKBOOTIMG_ARGS += --second_offset 0xf0000000
BOARD_RECOVERY_MKBOOTIMG_ARGS += --dtb_offset 0x00000000
BOARD_RECOVERY_MKBOOTIMG_ARGS += --header_version 2
BOARD_RECOVERY_MKBOOTIMG_ARGS += --board SRPUJ28A004

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_LLVM_BINUTILS := false
TARGET_KERNEL_VERSION := 5.10
TARGET_KERNEL_ADDITIONAL_FLAGS += LLVM=1 LLVM_IAS=1 ARCH=arm64 TARGET_SOC=s5e8825

# DTBO
BOARD_KERNEL_SEPARATED_DTBO := true

# DTB
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_DTB_CFG := $(COMMON_PATH)/configs/kernel/$(TARGET_SOC).cfg

# Fingerprint
TARGET_SEC_FP_REQUEST_FORCE_CALIBRATE := true

# UDFPS
TARGET_SURFACEFLINGER_UDFPS_LIB := //$(COMMON_PATH):libudfps_extension.universal8825
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS := 0x2000U | 0x400000000LL

# libinit
TARGET_INIT_VENDOR_LIB := //$(COMMON_PATH):init_universal8825

## Manifest
DEVICE_MANIFEST_FILE += $(COMMON_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(COMMON_PATH)/compatibility_matrix.xml

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    $(COMMON_PATH)/device_framework_matrix.xml \
    vendor/lineage/config/device_framework_matrix.xml

# Recovery
BOARD_HAS_DOWNLOAD_MODE := true
BOARD_USES_FULL_RECOVERY_IMAGE := true
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USES_MKE2FS := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/configs/init/recovery.fstab

# Releasetools
TARGET_RECOVERY_UPDATER_LIBS := librecovery_updater_exynos1280
TARGET_RELEASETOOLS_EXTENSIONS := $(COMMON_PATH)/releasetools

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Security patch
VENDOR_SECURITY_PATCH := 2023-01-01

# SePolicy
BOARD_SEPOLICY_TEE_FLAVOR := teegris
include device/lineage/sepolicy/exynos/sepolicy.mk
include device/samsung_slsi/sepolicy/sepolicy.mk

BOARD_VENDOR_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy/vendor

## Wi-Fi
BOARD_WLAN_DEVICE                := slsi
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_slsi
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_slsi
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION           := VER_0_8_X

