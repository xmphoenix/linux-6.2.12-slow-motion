#!/bin/bash

#set -x

if [ $# -lt 1 ];then
    echo "Usage: $0 [arg]"
	echo "example :"
	echo "build.sh arm/arm64"
    exit 1
fi

if [ $1 = "arm32" ];then
	echo "The target system is ARM !"
    target=arm32
elif [ $1 = "arm64" ];then
	echo "The target system is ARM64 !"
	target=arm64
else
	echo "The target system is unknow !"
	exit 1
fi

uboot_build()
{
    set -x
    cd u-boot-2023.04
    if [ $target = "arm32" ];then
        make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- vexpress_ca9x4_defconfig
        make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j8
        #we do not know why we can not use the u-boot.bin file
        #qemu-system-arm -M vexpress-a9 -m 1024M -nographic -kernel u-boot
    elif [ $target = "arm64" ];then
        make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- vexpress_ca9x4_defconfig
        make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8
    else
        echo "the unkow ARCH system -uboot !"
        exit 1
    fi
    cd ../
    #cp u-boot-2023.04/u-boot ./ 
}

busybox_build()
{
    if [ ! -f "./rootfs/dev/console" ];then
        echo "the rootfs console inode is not exit !"
        mkdir -p rootfs/dev
        cd rootfs/dev
        sudo mknod console c 5 1
        cd ../../
    fi 
    
    cd busybox-1.36.0
    if [ $target = "arm32" ];then
        make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- defconfig
        make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- install -j8
    elif [ $target = "arm64" ];then
        make ARCH=arm64 CROSS_COMPILE=arm-linux-gnueabi- install -j8
        make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- install -j8
    else
        echo "the unkow ARCH system -busybox !"
        exit 2
    fi
    cd ../
    cp -rfd  busybox-1.36.0/_install/* rootfs/ 
}

kernel_build()
{
    cd linux-6.2.12
    if [ $target = "arm32" ];then
        make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- vexpress_defconfig
        make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- zImage -j8
        make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- dtbs
    elif [ $target = "arm64" ];then
        make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
        make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8
        make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- dtbs
    else   
        echo "the unkow ARCH system -kernel !"
        exit 3
    fi
    cd ../
    cp -rfd  linux-6.2.12/arch/arm/boot/zImage ./
    cp -rfd linux-6.2.12/arch/arm/boot/dts/vexpress-v2p-ca9.dtb ./
}

image_build()
{
    echo "we will build the full image here !"
}

qemu_boot()
{
    if [ $target = "arm32" ];then
        ./run.sh arm32
    elif [ $target = "arm64" ];then
        ./run.sh arm64
    else
        echo "the unknow qemu boot command !"
        exit 4
    fi
}

uboot_build
busybox_build
kernel_build
qemu_boot

