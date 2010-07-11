#!/bin/bash

if [[ -z "$1" ]]; then
  echo "usage: repackage-ota.sh <distilled-src-root>"
  exit 0
fi

SRC=$1

SIGNED=$SRC/out/target/product/passion/full_passion-ota-eng.$USER.zip
OUT=$SRC/distilled-update.zip
SIGNAPK=$SRC/out/host/linux-x86/framework/signapk.jar 
TESTCERT=$SRC/build/target/product/security/testkey.x509.pem
TESTKEY=$SRC/build/target/product/security/testkey.pk8
UPDATE_SCRIPT=META-INF/com/google/android/update-script

# remove unnecessary update scripts and recovery image
zip -d $SIGNED "/recovery/*"
zip -d $SIGNED "/META-INF/com/google/android/update-binary"
zip -d $SIGNED "/META-INF/com/google/android/updater-script"

# remove recovery from generated update-script 
unzip $SIGNED $UPDATE_SCRIPT
sed "s/^copy_dir PACKAGE:recovery.*$//" $UPDATE_SCRIPT > $UPDATE_SCRIPT.new
mv $UPDATE_SCRIPT.new $UPDATE_SCRIPT
sed "s/^.*recovery.sh.*$//" $UPDATE_SCRIPT > $UPDATE_SCRIPT.new
mv $UPDATE_SCRIPT.new $UPDATE_SCRIPT
zip -f $SIGNED $UPDATE_SCRIPT
rm -rf META-INF

# resign
rm $OUT
java -jar $SIGNAPK $TESTCERT $TESTKEY $SIGNED $OUT
jarsigner -verify -verbose -certs $OUT
