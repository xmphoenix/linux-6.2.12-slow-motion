#!/bin/bash

LROOT=$PWD

if [ $# -lt 1 ]; then
	echo "Usage: $0 [arch] [debug]"
fi

if [ $# -eq 2 ] && [ $2 == "debug" ]; then
	echo "Enable GDB debug mode"
	DBG="-s -S"
fi

case $1 in
	
    arm32)
		qemu-system-arm -M vexpress-a9 -smp 4 -m 100M -kernel zImage \
				-dtb vexpress-v2p-ca9.dtb -nographic \
				-append "rdinit=/linuxrc console=ttyAMA0 " \
				--fsdev local,id=kmod_dev,path=$PWD/kmodules,security_model=none -device virtio-9p-device,fsdev=kmod_dev,mount_tag=kmod_mount \
				$DBG ;;
	arm64)
		qemu-system-aarch64 -machine virt -cpu cortex-a57 -machine type=virt \
				    -m 100 -smp 2 -kernel Image \
				    --append "rdinit=/linuxrc console=ttyAMA0" -nographic \
				    --fsdev local,id=kmod_dev,path=$PWD/kmodules,security_model=none -device virtio-9p-device,fsdev=kmod_dev,mount_tag=kmod_mount \
				    $DBG ;;
esac
