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

bootparams = "-b vendor:raspberry,model:pi4B,serial:1234567,sku:RP4B4GB,vendorurl:www.raspberrypi.com,modelurl:vilros.com/products/raspberry-pi-4-4gb-ram?src=raspberrypi,presentationurl:www.raspberry.com"


args+=bootparams

/usr/sbin/wsdd2 ${args} --debug-stdout & wait 

exit $?
