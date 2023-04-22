#!/bin/bash

if [ $# -lt 1 ]; then
        echo "Usage: $0 [arch:arm32/arm64] "
fi

cd linux-6.2.12
if [ -f "vmlinux-add-symbol-file-addr.sh" ];then
    fix_addr=`sh ./vmlinux-add-symbol-file-addr.sh`
    echo $fix_addr
    sed -i '/add-symbol-file/c'"${fix_addr}"'' ~/.gdbinit
    cd ../
    sync
else
    cd ../
    echo "we can not update the gdbinit script !"
    exit 1
fi

if [ $1 == "arm32" ]; then
    ./run.sh arm32 debug &
    cd linux-6.2.12
    gdb-multiarch
    killall qemu-system-arm
elif [ $1 == "arm64" ];then
    ./run.sh arm64 debug &
    cd linux-6.2.12
    gdb-multiarch
    killall qemu-system-aarch64
else 
    echo "the unsupport the arch $1"
fi

exit 0
