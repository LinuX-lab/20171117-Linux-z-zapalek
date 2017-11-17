#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage:"
	echo "   $0 FILE_NAME"
	exit 1
fi

qemu-system-x86_64 -drive file=${1},index=0,media=disk,format=raw -accel kvm

