#!/bin/bash

DATE=20$1
[[ 20 -eq ${DATE} ]] && DATE=`expr $(date +'%G%m%d') - 2`

source /etc/portage/make.conf
SQFS_DIRNAME=/home/portage/squashfs
SQFS_MIRRORS="http://mirrors.163.com/gentoo/snapshots/squashfs"
# SQFS_MIRRORS="http://mirrors.aliyun.com/gentoo/snapshots/squashfs"
#SQFS_MIRRORS="http://mirrors.ustc.edu.cn/gentoo/snapshots/squashfs"

# SQFS_YESTERD=gentoo-`expr $(date +'%G%m%d') - 2`.lzo.sqfs
SQFS_YESTERD=gentoo-${DATE}.xz.sqfs
SQFS_CURRENT=${SQFS_DIRNAME}/gentoo-current.xz.sqfs

sudo mkdir ${SQFS_DIRNAME}
cd ${SQFS_DIRNAME}
# cd /tmp
sudo wget -c ${SQFS_MIRRORS}/${SQFS_YESTERD} || {
    echo no update.
    exit 1
    }
sudo ln -vsf ${SQFS_YESTERD} ${SQFS_DIRNAME}/gentoo-current.xz.sqfs
sudo umount -f -l -t squashfs ${PORTDIR}
sleep 1
sudo mount -rt squashfs -o loop,nodev,noexec ${SQFS_CURRENT} ${PORTDIR}
eix-update
eix-diff | grep "^\[U"
sudo emerge -vauDN --with-bdeps\=y world
