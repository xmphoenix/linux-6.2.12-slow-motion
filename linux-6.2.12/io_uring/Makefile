# SPDX-License-Identifier: GPL-2.0
#
# Makefile for io_uring

CFLAGS_io_uring.o += -O

obj-$(CONFIG_IO_URING)		+= io_uring.o xattr.o nop.o fs.o splice.o \
					sync.o advise.o filetable.o \
					openclose.o uring_cmd.o epoll.o \
					statx.o net.o msg_ring.o timeout.o \
					sqpoll.o fdinfo.o tctx.o poll.o \
					cancel.o kbuf.o rsrc.o rw.o opdef.o notif.o
obj-$(CONFIG_IO_WQ)		+= io-wq.o
