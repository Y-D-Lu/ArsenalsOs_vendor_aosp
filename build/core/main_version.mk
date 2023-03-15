# Build fingerprint
ifeq ($(BUILD_FINGERPRINT),)
BUILD_NUMBER_CUSTOM := $(shell date -u +%H%M)
CUSTOM_DEVICE ?= $(TARGET_DEVICE)
ifneq ($(filter OFFICIAL,$(CUSTOM_BUILD_TYPE)),)
BUILD_SIGNATURE_KEYS := release-keys
else
BUILD_SIGNATURE_KEYS := test-keys
endif
BUILD_FINGERPRINT := $(PRODUCT_BRAND)/$(CUSTOM_DEVICE)/$(CUSTOM_DEVICE):$(PLATFORM_VERSION)/$(BUILD_ID)/$(BUILD_NUMBER_CUSTOM):$(TARGET_BUILD_VARIANT)/$(BUILD_SIGNATURE_KEYS)
endif
ADDITIONAL_SYSTEM_PROPERTIES  += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)

# AOSP recovery flashing
ifeq ($(TARGET_USES_AOSP_RECOVERY),true)
ADDITIONAL_SYSTEM_PROPERTIES  += \
    persist.sys.recovery_update=true
endif

# Custom security patch
CUSTOM_SECURITY_PATCH := 1970-01-01

# Versioning props
ADDITIONAL_SYSTEM_PROPERTIES  += \
    cn.arsenals.os.version=$(CUSTOM_VERSION_PROP) \
    cn.arsenals.os.version.display=$(CUSTOM_VERSION) \
    cn.arsenals.os.build_date=$(CUSTOM_BUILD_DATE) \
    cn.arsenals.os.build_date_utc=$(CUSTOM_BUILD_DATE_UTC) \
    cn.arsenals.os.build_type=$(CUSTOM_BUILD_TYPE) \
    cn.arsenals.os.build_security_patch=$(CUSTOM_SECURITY_PATCH)
