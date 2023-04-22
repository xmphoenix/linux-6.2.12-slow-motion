#!/bin/bash

if [ ! -f ./vmlinux ];then
    echo "You need to compile the vmlinux firstly !"
    exit 1
fi

#^8 means the kernel space addr is from the 0x80
#0x6 means we need to adjust the kernel virtual addrs 0x8xxx to 0x6xxx
#for linux_6.0 kernel virtual addrs base is the 0x8xxx and Memory physics address is 0x6xxx 
text_addr=`readelf -S vmlinux | grep text | awk '{if (NR==2) {print $5}}'|sed 's/^8/0x6/g'`
head_text_addr=`readelf -S vmlinux | grep head.text | awk -F " " '{print $5}' | sed 's/^8/0x6/g'`
ro_data_addr=`readelf -S vmlinux | grep rodata | awk -F " " '{print $5}' |sed 's/^8/0x6/g'`

echo "add-symbol-file vmlinux $text_addr -s .head.text $head_text_addr -s .rodata $ro_data_addr"

