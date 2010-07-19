#!/bin/bash

# pull down FRF91 OTA package. proprietary files will be 
# extracted from this
if [[ ! -f passion_update.zip ]]; then
  PASSION_BUILD="signed-passion-ota-43546.cc653ee4.zip"
  wget "http://android.clients.google.com/packages/passion/$PASSION_BUILD"
  mv $PASSION_BUILD passion_update.zip
fi

# prefer su from ChainsDD Superuser
SU_MK=system/extras/su/Android.mk
rm $SU_MK
touch $SU_MK

# tweak ChainsDD superuser Makefile. I'd rather use this
# simple awk command than maintain my own branch
SUPERUSER_APP_MK=packages/apps/Superuser/Android.mk
sed "s/^LOCAL_MODULE_TAGS.*$//" $SUPERUSER_APP_MK > $SUPERUSER_APP_MK.new
mv $SUPERUSER_APP_MK.new $SUPERUSER_APP_MK

# G1 compatibility
cp build/patches/libaudio.dream.Android.mk hardware/msm7k/libaudio/Android.mk
cp build/patches/dalvik.vm.Android.mk dalvik/vm/Android.mk

# updates the script that generates passion.mk to include
# custom build.prop settings so the Market works properly.
# this is just a hack because the devices/htc/passion.git
# isn't mirrored on github, and i don't want to host my
# own.
cp build/patches/passion.setup-makefiles.sh device/htc/passion/setup-makefiles.sh
cp build/patches/dream.setup-makefiles.sh device/htc/dream/setup-makefiles.sh

# create passion makefiles
pushd device/htc/passion/
./unzip-files.sh
./setup-makefiles.sh
popd

# create dream makefiles
pushd device/htc/dream/
./extract-files.sh
./setup-makefiles.sh
popd
