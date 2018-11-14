#!/usr/bin/env bash

exec /workspace/socketpolicy/socketpolicy.pl > /dev/null &

tail -f /workspace/flash_socket_policy.log
