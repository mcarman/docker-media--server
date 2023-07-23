#!/usr/bin/env bash

set -e
set -o pipefail

args=

if [ ! -z "${WSDD_ARGS}" ]; then
  args=${WSDD_ARGS}
else
	if [ ! -z "${HOSTNAME}" ]; then
		args+="-n $HOSTNAME "
	else
		echo "HOSTNAME environment variable must be set."
		exit 1
	fi

	if  [ ! -z "${WORKGROUP}" ]; then
		args+="-w $WORKGROUP "
	fi

	if  [ ! -z "${DOMAIN}" ]; then
		args+="-d $DOMAIN "
	fi
fi

#  termiaton command  capture and graceful shutdown

handle_signal() {
  PID=$!
  echo "Received signal. PID is ${PID}"
  kill -s SIGHUP $PID
}

trap "handle_signal" SIGINT SIGTERM SIGHUP

python wsdd.py ${args} --debug-stdout & wait 

exit $?
