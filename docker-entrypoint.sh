#!/usr/bin/env bash
LOGFILE=/workspace/flash_socket_policy.log
exec /workspace/socketpolicy/socketpolicy.pl > /dev/null &

if [ -f "$LOGFILE" ];then
  tail -f "$LOGFILE"
fi

