#!/bin/bash

set -e

export JAVA_HOME="${SNAP_COMMON}/jvm/java-8-openjdk-amd64/jre"
export ZOO_LOG_DIR="${SNAP_COMMON}/logs"
export ZOOCFGDIR="${SNAP_COMMON}"

"${SNAP}"/usr/bin/setpriv \
    --clear-groups \
    --reuid snap_daemon \
    --regid snap_daemon -- \
    "${SNAP}/${1}" --config "${SNAP_COMMON}" $2
