#!/bin/sh

# Copyright (C) 2010 The Android Open Source Project
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

DEVICE=passion

mkdir -p ../../../vendor/htc/$DEVICE

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g > ../../../vendor/htc/$DEVICE/$DEVICE-vendor.mk
# Copyright (C) 2010 The Android Open Source Project
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

# This file is generated by device/htc/__DEVICE__/setup-makefiles.sh

# Live wallpaper packages
PRODUCT_PACKAGES := \\
    LiveWallpapers \\
    LiveWallpapersPicker \\
    MagicSmokeWallpapers \\
    VisualizationWallpapers \\
    Superuser \\
    librs_jni

# Publish that we support the live wallpaper feature.
PRODUCT_COPY_FILES := \\
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:/system/etc/permissions/android.software.live_wallpaper.xml

# make more enterprisey
PRODUCT_PROPERTY_OVERRIDES += \\
    keyguard.no_require_sim=true \\
    ro.com.android.dataroaming=false \\
    ro.com.google.clientidbase=android-google \\
    ro.config.alarm_alert=Alarm_Classic.ogg \\
    ro.config.notification_sound=pixiedust.ogg \\
    ro.config.ringtone=Ring_Digital_02.ogg \\
    ro.config.sync=yes \\
    ro.media.dec.aud.wma.enabled=1 \\
    ro.media.dec.vid.wmv.enabled=1 \\
    ro.modversion=distilled-0.200 \\
    ro.rommanager.developerid=avatar \\
    ro.setupwizard.enterprise_mode=1 \\
    ro.setupwizard.mode=OPTIONAL

# protected apps market hack
PRODUCT_BUILD_PROP_OVERRIDES += \\
    BUILD_ID=FRF91 \\
    BUILD_DISPLAY_ID=FRF91 \\
    PRODUCT_NAME=passion \\
    BUILD_VERSION_TAGS="ota-rel-keys,test-keys" \\
    BUILD_FINGERPRINT="google/passion/passion/mahimahi:2.2/FRF91/43546:user/release-keys" \\
    PRIVATE_BUILD_DESC="passion-user 2.2 FRF91 43546 release-keys"

# Pick up overlay for features that depend on non-open-source files
DEVICE_PACKAGE_OVERLAYS := vendor/htc/__DEVICE__/overlay

\$(call inherit-product, vendor/htc/__DEVICE__/__DEVICE__-vendor-blobs.mk)
EOF

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g > ../../../vendor/htc/passion/BoardConfigVendor.mk
# Copyright (C) 2010 The Android Open Source Project
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

# This file is generated by device/htc/__DEVICE__/setup-makefiles.sh

BOARD_GPS_LIBRARIES := libgps

USE_CAMERA_STUB := false
EOF

mkdir -p ../../../vendor/htc/passion/overlay/packages/apps/Launcher2/res/layout
(cat << EOF) | sed s/__DEVICE__/$DEVICE/g > ../../../vendor/htc/passion/overlay/packages/apps/Launcher2/res/layout/all_apps.xml
<?xml version="1.0" encoding="utf-8"?>
<!-- Copyright (C) 2010 The Android Open Source Project

     Licensed under the Apache License, Version 2.0 (the "License");
     you may not use this file except in compliance with the License.
     You may obtain a copy of the License at

          http://www.apache.org/licenses/LICENSE-2.0

     Unless required by applicable law or agreed to in writing, software
     distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and
     limitations under the License.
-->

<!-- This file is generated by device/htc/__DEVICE__/setup-makefiles.sh -->

<!-- switch to all_apps_3d on devices that support RenderScript -->
<merge xmlns:android="http://schemas.android.com/apk/res/android">
    <include layout="@layout/all_apps_3d" />
</merge>
EOF
