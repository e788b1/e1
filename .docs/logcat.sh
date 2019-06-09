#!/bin/bash

folder="bugreport-"`date +%s`
echo "Please connect your phone."
adb wait-for-device
adb root

mkdir -v  "$folder"
adb logcat -t 10000 -v time > "$folder"/logcat.log
adb logcat -b radio -t 10000 -v time > "$folder"/radio.log
adb shell dmesg > "$folder"/dmesg.log
adb shell cat /proc/last_kmsg > "$folder"/last_kmsg.log
adb pull /data/anr/traces.txt "$folder"/traces.log
adb pull /data/tombstones "$folder"/tombstones

adb shell 'setprop service.adb.root 0; setprop ctl.restart adbd'

apack bugreport-`date +%m%d-%H%M%S`.zip "$folder"

#EOF
