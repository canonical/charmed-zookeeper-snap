#!/bin/bash

set -e

export CONFIG_FILE="${SNAP_COMMON}/zoo.cfg"
if [ ! -f "${CONFIG_FILE}" ]; then
	echo "custom configuration file ${CONFIG_FILE} does not exist."
	echo "copying default config to ${CONFIG_FILE}"
	cp $SNAP/conf/zoo_sample.cfg $CONFIG_FILE
fi

export PATH="${SNAP}/usr/lib/jvm/default-java/bin:${PATH}"
export LOG_DIR="${SNAP_COMMON}/log"
export JAVA_HOME=$SNAP/usr/lib/jvm/java-8-openjdk-amd64/jre
export ZOOCFGDIR="${SNAP_COMMON}"

if [ -z $2 ]
then
	"${SNAP}/${1}" --config "${SNAP_COMMON}"
else
	"${SNAP}/${1}" --config "${SNAP_COMMON}" $2
fi