# Copyright (C) 2020 The Android Open Source Project
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
# This file is the build configuration for a full Android
# build for grouper hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#

# Inherit some common AOSP stuff
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

# Inherit some common AOSP Base stuff
$(call inherit-product, vendor/aosp/config/common_full_phone.mk)

# Device
$(call inherit-product, device/motorola/doha/device.mk)

# Gapps
TARGET_GAPPS_ARCH := arm64

# A/B updater
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
     boot \
     system \
     vendor

AB_OTA_POSTINSTALL_CONFIG += \
     RUN_POSTINSTALL_system=true
     POSTINSTALL_PATH_system=system/bin/otapreopt_script \
     FILESYSTEM_TYPE_system=ext4 \
     POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
     otapreopt_script \
     update_engine \
     update_engine_sideload \
     update_verifier

# The following modules are included in debuggable builds only.
PRODUCT_PACKAGES_DEBUG += \
     bootctl \
     update_engine_client

# Boot control HAL (Soon)
#PRODUCT_PACKAGES += \
    # \
    # \
    # 


# Recovery
TARGET_RECOVERY_FSTAB := device/motorola/doha/recovery.fstab

# Device identifiers
PRODUCT_DEVICE := doha
PRODUCT_NAME := aosp_doha
PRODUCT_BRAND := motorola
PRODUCT_MODEL := Moto G8 Plus
PRODUCT_MANUFACTURER := Motorola
PRODUCT_RELASE_NAME := doha

PRODUCT_BUILD_PROP_OVERRIDES += \
     PRODUCT_NAME= doha
     PRIVATE_BUILD_DESC= "doha-user 9.0.0 PPIS29.65-24-2 release-keys"

# Fingerprint
BUILD_FINGERPRINT := motorola/doha/doha:10/QPI30.28-Q3-28-13/23080:user/release-keys
