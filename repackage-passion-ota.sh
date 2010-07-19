#!/bin/bash

if [[ -z "$1" ]]; then
  echo "usage: repackage-ota.sh <distilled-src-root>"
  exit 0
fi

SRC=$1

SIGNED=$SRC/out/target/product/passion/full_passion-ota-eng.$USER.zip
OUT=$SRC/distilled-passion-update.zip
SIGNAPK=$SRC/out/host/linux-x86/framework/signapk.jar 
TESTCERT=$SRC/build/target/product/security/testkey.x509.pem
TESTKEY=$SRC/build/target/product/security/testkey.pk8
UPDATE_SCRIPT=META-INF/com/google/android/update-script

if [[ -f $OUT ]]; then
  rm $OUT
fi

cp $SIGNED $OUT

# remove unnecessary update scripts and recovery image
zip -d $OUT "/recovery/*"
zip -d $OUT "/META-INF/com/google/android/update-binary"
zip -d $OUT "/META-INF/com/google/android/updater-script"

# remove recovery from generated update-script 
unzip $OUT $UPDATE_SCRIPT
sed "s/^copy_dir PACKAGE:recovery.*$//" $UPDATE_SCRIPT > $UPDATE_SCRIPT.new
mv $UPDATE_SCRIPT.new $UPDATE_SCRIPT
sed "s/^.*recovery\.sh.*$//" $UPDATE_SCRIPT > $UPDATE_SCRIPT.new
mv $UPDATE_SCRIPT.new $UPDATE_SCRIPT
zip -f $SIGNED $UPDATE_SCRIPT
rm -rf META-INF

# resign
java -jar $SIGNAPK $TESTCERT $TESTKEY $OUT $OUT.new
jarsigner -verify -verbose -certs $OUT.new
mv $OUT.new $OUT
