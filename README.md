# linux-6.2.12-slow-motion

STEPS:
1.compile
    mkdir -p rootfs/dev
    cd rootfs/dev
    sudo mknod console c 5 1
    ./build.sh arm32
2.set the .gdbinit
    ybzhang@ybzhang-VirtualBox:~/linux-6.2.12-slow-motion$ cat ~/.gdbinit
    file vmlinux
    #add-symbol-file vmlinux 0x80100000 -s .head.text 0x80008000 -s .rodata 0x80900000
    target remote localhost:1234
    set disassemble-next-line on
    b stext
    b start_kernel
    layout src
    layout regs
    c
2.1 add-symbol-file
    please switch the linux-6.2.12 and run the below script
    ./vmlinux-add-symbol-file-addr.sh
3.debug the kernel
    ./lanuch arm32
