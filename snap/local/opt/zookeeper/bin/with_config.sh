#!/bin/bash

set -e

if [ "x$ZOO_LOG4J_PROP" = "x" ]; then
    export ZOO_LOG4J_PROP="INFO,ROLLINGFILE"
fi

"${SNAP}"/usr/bin/setpriv \
    --clear-groups \
    --reuid snap_daemon \
    --regid snap_daemon -- \
    "${SNAP}/opt/zookeeper/${1}" --config "${SNAP_DATA}"/etc/zookeeper $2
