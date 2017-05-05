# Boot animation
TARGET_SCREEN_HEIGHT := 2560
TARGET_SCREEN_WIDTH := 1440

# Inherit Broken common.
$(call inherit-product, vendor/broken/config/common_full_phone.mk)

# Inherit AOSP device configuration
$(call inherit-product, device/huawei/angler/aosp_angler.mk)

## Device identifier. This must come after all inclusions
PRODUCT_NAME := broken_angler
PRODUCT_BRAND := google
PRODUCT_DEVICE := angler
PRODUCT_MODEL := Nexus 6P
PRODUCT_MANUFACTURER := Huawei

# Copy over Flash Kernel ramdisk files
PRODUCT_COPY_FILES += \
    vendor/huawei/angler/prebuilt/ramdisk/init.flash.rc:root/init.flash.rc \
    vendor/huawei/angler/prebuilt/ramdisk/init.profiles.rc:root/init.profiles.rc \
    vendor/huawei/angler/prebuilt/ramdisk/init.profiles.sh:root/init.profiles.sh \
    vendor/huawei/angler/prebuilt/ramdisk/init.special_power.sh:root/init.special_power.sh \
    vendor/huawei/angler/prebuilt/ramdisk/msm_irqbalance.conf:root/msm_irqbalance.conf

# Broken Device Maintainer
PRODUCT_BUILD_PROP_OVERRIDES += \
	DEVICE_MAINTAINERS="Jarrod Worlitz (drgroovestarr)"

# Device Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=angler \
    BUILD_FINGERPRINT=google/angler/angler:7.1.2/N2G48B/4073501:user/release-keys \
    PRIVATE_BUILD_DESC="angler-user 7.1.2 N2G48B 4073501 release-keys"
