#!/usr/bin/env bash
LOGFILE=/deployments/flash_socket_policy.log
exec /deployments/socketpolicy/socketpolicy.pl > /dev/null & \
     tail -f "$LOGFILE"

