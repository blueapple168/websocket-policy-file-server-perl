#!/usr/bin/env bash
LOGFILE=/workspace/flash_socket_policy.log
exec /workspace/socketpolicy/socketpolicy.pl > /dev/null & \
     tail -f "$LOGFILE"

