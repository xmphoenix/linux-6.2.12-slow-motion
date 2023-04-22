# SPDX-License-Identifier: GPL-2.0

CFLAGS_journal.o += -O
CFLAGS_super.o += -O
CFLAGS_sb.o += -O
CFLAGS_io.o += -O
CFLAGS_tnc.o += -O
CFLAGS_master.o += -O
CFLAGS_replay.o += -O
CFLAGS_log.o += -O
CFLAGS_gc.o += -O
CFLAGS_tnc_commit.o += -O
CFLAGS_lpt.o += -O
CFLAGS_tnc_misc.o += -O

obj-$(CONFIG_UBIFS_FS) += ubifs.o

ubifs-y += shrinker.o journal.o file.o dir.o super.o sb.o io.o
ubifs-y += tnc.o master.o scan.o replay.o log.o commit.o gc.o orphan.o
ubifs-y += budget.o find.o tnc_commit.o compress.o lpt.o lprops.o
ubifs-y += recovery.o ioctl.o lpt_commit.o tnc_misc.o debug.o
ubifs-y += misc.o sysfs.o
ubifs-$(CONFIG_FS_ENCRYPTION) += crypto.o
ubifs-$(CONFIG_UBIFS_FS_XATTR) += xattr.o
ubifs-$(CONFIG_UBIFS_FS_AUTHENTICATION) += auth.o
