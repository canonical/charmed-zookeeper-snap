#!/bin/bash

set -e

"${SNAP}"/usr/bin/setpriv \
    --clear-groups \
    --reuid snap_daemon \
    --regid snap_daemon -- \
    "${SNAP}/opt/zookeeper/${1}" --config "${SNAP_DATA}"/etc/zookeeper $2
