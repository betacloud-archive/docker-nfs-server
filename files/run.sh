#!/usr/bin/env bash
set -x

# This file is subject to the terms and conditions defined in file 'LICENSE',
# which is part of this repository.

# Available environment variables
#
# n/a

# generate /etc/exports file

for export in $(find /exports -mindepth 1 -maxdepth 1 -type d); do
    echo "$export *(rw,insecure,sync,no_subtree_check,fsid=0,no_root_squash)" >> /etc/exports
done

# https://github.com/AJNOURI/nfs-server/blob/master/nfs-run.sh

. /etc/default/nfs-kernel-server
. /etc/default/nfs-common

rpcbind
rpc.statd -d
rpc.nfsd
rpc.mountd $RPCMOUNTDOPTS --foreground
