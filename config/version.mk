# Copyright (C) 2016 The Pure Nexus Project
# Copyright (C) 2016 The JDCTeam
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

SWIP_MOD_VERSION := 13.0
SWIP_BUILD_TYPE := UNOFFICIAL
SWIP_BUILD_ZIP_TYPE := VANILLA

SWIP_MAINTAINER?=NOBODY

ifeq ($(SWIP_GAPPS), true)
    $(call inherit-product, vendor/gapps/common/common-vendor.mk)
    SWIP_BUILD_ZIP_TYPE := GAPPS
endif

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

ifeq ($(SWIP_OFFICIAL), true)
   LIST = $(shell cat infrastructure/devices/swip.devices | awk '$$1 != "#" { print $$2 }')
    ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
      IS_OFFICIAL=true
      SWIP_BUILD_TYPE := OFFICIAL

PRODUCT_PACKAGES += \
    Updater

    endif
    ifneq ($(IS_OFFICIAL), true)
       SWIP_BUILD_TYPE := UNOFFICIAL
       $(error Device is not official "$(CURRENT_DEVICE)")
    endif
endif

SWIP_VERSION := SwipOS-$(SWIP_MOD_VERSION)-$(CURRENT_DEVICE)-$(SWIP_BUILD_TYPE)-$(shell date -u +%Y%m%d)-$(SWIP_BUILD_ZIP_TYPE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.swip.version=$(SWIP_VERSION) \
  ro.swip.releasetype=$(SWIP_BUILD_TYPE) \
  ro.swip.ziptype=$(SWIP_BUILD_ZIP_TYPE) \
  ro.swip.maintainer=$(SWIP_MAINTAINER) \
  ro.modversion=$(SWIP_MOD_VERSION)

SWIP_DISPLAY_VERSION := SwipOS-$(SWIP_MOD_VERSION)-$(SWIP_BUILD_TYPE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.swip.display.version=$(SWIP_DISPLAY_VERSION)
