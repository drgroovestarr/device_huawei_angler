# Explanation: https://github.com/opengapps/aosp_build

# Base package
GAPPS_VARIANT := micro

# Extra desired packages
PRODUCT_PACKAGES += \
	GoogleCamera \
	LatinImeGoogle \
	PrebuiltBugle

# Packages from vendor
PRODUCT_PACKAGES += \
	GCS \
	Tycho

# Excluded packages
GAPPS_EXCLUDED_PACKAGES += \
        CalendarGooglePrebuilt \
	GooglePackageInstaller \
	PrebuiltGmail \
	GoogleHome

# Messanging override
APPS_FORCE_MMS_OVERRIDES := true

