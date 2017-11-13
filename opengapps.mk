# Explanation: https://github.com/opengapps/aosp_build

# Base package
GAPPS_VARIANT := mini

# Extra desired packages
PRODUCT_PACKAGES += \
	CloudPrint2 \
	Drive \
	GoogleCamera \
	LatinImeGoogle \
	Music2 \
	PrebuiltBugle \
	PrebuiltKeep \
	Street \
	Wallpapers

# Packages from vendor
PRODUCT_PACKAGES += \
	GCS \
	Tycho

# Excluded packages
GAPPS_EXCLUDED_PACKAGES += \
	GoogleHome

# Messanging override
APPS_FORCE_MMS_OVERRIDES := true
