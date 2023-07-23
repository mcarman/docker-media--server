#!/bin/bash

# /config

set -e
set -o pipefail

handle_signal() {
  PID=$!
  echo "Received signal. PID is ${PID}"
  kill -s SIGHUP $PID
}

trap "handle_signal" SIGINT SIGTERM SIGHUP

/usr/sbin/smbd --foreground --no-process-group --debug-stdout & wait 

exit $?