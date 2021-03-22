#!/bin/sh

# android also has bash
# install adb and adb-fastboot

adb devices
adb shell
adb pull /sdcard [custom location]

adb backup -apk -shared -all -f backup.ab
adb restore backup.ab

adb shell pm list packages -f -3
for APP in $(adb shell pm list packages -3 -f)
do
  adb pull "$( echo "${APP}" | sed "s/^package://" | sed "s/base.apk=/base.apk /")".apk
done

#dd if=freeotp.adb bs=24 skip=1 | zlib-flate -uncompress | tar xf -

Will have to change AndroidManifest.xml in apk with 'android:allowBackup="true"'
