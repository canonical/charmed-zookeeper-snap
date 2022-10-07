#!/bin/bash

set -e

export CONFIG_FILE="${SNAP_COMMON}/zoo.cfg"
if [ ! -f "${CONFIG_FILE}" ]; then
	echo "custom configuration file ${CONFIG_FILE} does not exist."
	echo "copying default config to ${CONFIG_FILE}"
	cp $SNAP/conf/zoo_sample.cfg $CONFIG_FILE
fi

export PATH="${SNAP}/usr/lib/jvm/default-java/bin:${PATH}"
export JAVA_HOME="${SNAP}/usr/lib/jvm/java-8-openjdk-amd64/jre"
export ZOO_LOG_DIR="${SNAP_COMMON}/logs"
export ZOOCFGDIR="${SNAP_COMMON}"

cp -r "${SNAP}/conf/log4j.properties" ${SNAP_COMMON}

"${SNAP}/${1}" --config "${SNAP_COMMON}" $2
