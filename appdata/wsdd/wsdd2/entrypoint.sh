#!/usr/bin/env bash

set -e
set -o pipefail

args=

if [ ! -z "${WSDD_ARGS}" ]; then
  args=${WSDD_ARGS}
else
	if [ ! -z "${HOSTNAME}" ]; then
		args+="-N $HOSTNAME "
	else
		echo "HOSTNAME environment variable must be set."
		exit 1
	fi

	if  [ ! -z "${WORKGROUP}" ]; then
		args+="-G $WORKGROUP "
	fi

	if  [ ! -z "${DOMAIN}" ]; then
		args+="-D $DOMAIN "
	fi
fi

#  termiaton command  capture and graceful shutdown

handle_signal() {
  PID=$!
  echo "Received signal. PID is ${PID}"
  kill -s SIGHUP $PID
}

trap "handle_signal" SIGINT SIGTERM SIGHUP

/usr/sbin/wsdd2 ${args} --debug-stdout & wait 

exit $?
