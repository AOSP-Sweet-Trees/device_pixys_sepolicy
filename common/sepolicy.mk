#
# This policy configuration will be used by all products that
# inherit from Pixys
#

ifeq ($(TARGET_COPY_OUT_VENDOR), vendor)
ifeq ($(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE),)
TARGET_USES_PREBUILT_VENDOR_SEPOLICY ?= true
endif
endif

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += \
    device/pixys/sepolicy/common/public

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/pixys/sepolicy/common/private

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/pixys/sepolicy/common/dynamic \
    device/pixys/sepolicy/common/system \
    hardware/google/pixel-sepolicy/flipendo \
    hardware/google/pixel-sepolicy/turbo_adapter
else
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/pixys/sepolicy/common/dynamic \
    device/pixys/sepolicy/common/vendor \
    hardware/google/pixel-sepolicy/flipendo \
    hardware/google/pixel-sepolicy/turbo_adapter
endif

ifneq ($(TARGET_SUPPORTS_GOOGLE_BATTERY), true)
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/custom/sepolicy/common/googlebattery
endif

# Selectively include legacy rules defined by the products
-include device/pixys/sepolicy/legacy-common/sepolicy.mk

# Include atv rules on atv product
ifeq ($(PRODUCT_IS_ATV), true)
include device/pixys/sepolicy/atv/sepolicy.mk
endif
