#!/bin/bash

function main() {
	/usr/bin/true # TODO: wait for device usb connection <17-03-21, melthsked> #
	watch adb devices # wait for user confirmation on device
	time watch adb devices | grep "device" # until successful
	adb tcpip 5555
	adh shell
	ip addr show # grep, cut, and awk for grabbing IP and store as variable
	exit
	adb connect ip:5555
}

if ! main; then exit 1
else exit 0; fi
