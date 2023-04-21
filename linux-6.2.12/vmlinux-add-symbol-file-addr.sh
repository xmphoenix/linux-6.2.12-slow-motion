#!/bin/bash

text_addr=`readelf -S vmlinux | grep text | awk '{if (NR==2) {print $5}}'|sed 's/^c/0x6/g'`
head_text_addr=`readelf -S vmlinux | grep head.text | awk -F " " '{print $5}' | sed 's/^c/0x6/g'`
ro_data_addr=`readelf -S vmlinux | grep rodata | awk -F " " '{print $5}' |sed 's/^c/0x6/g'`

echo "add-symbol-file vmlinux 0x$text_addr -s .head.text 0x$head_text_addr -s .rodata 0x$ro_data_addr"

