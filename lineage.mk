# Boot animation
TARGET_SCREEN_HEIGHT := 2560
TARGET_SCREEN_WIDTH := 1440

# Inherit some common stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Copy over our ramdisk files
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/ramdisk/init.flash.rc:root/init.flash.rc \
    vendor/cm/prebuilt/ramdisk/init.profiles.rc:root/init.profiles.rc \
    vendor/cm/prebuilt/ramdisk/init.profiles.sh:root/init.profiles.sh \
    vendor/cm/prebuilt/ramdisk/init.special_power.sh:root/init.special_power.sh \
    vendor/cm/prebuilt/ramdisk/msm_irqbalance.conf:root/msm_irqbalance.conf

# Inherit device configuration
$(call inherit-product, device/huawei/angler/aosp_angler.mk)

## Device identifier. This must come after all inclusions
PRODUCT_NAME := lineage_angler
PRODUCT_BRAND := google
PRODUCT_MODEL := Nexus 6P

TARGET_VENDOR := huawei

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=angler \
    BUILD_FINGERPRINT=google/angler/angler:7.1.2/N2G47O/3852959:user/release-keys \
    PRIVATE_BUILD_DESC="angler-user 7.1.2 N2G47O 3852959 release-keys"
