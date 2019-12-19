#!/bin/bash

NOIP_EXEC=${1:-/usr/local/bin/noip2}
USERNAME=$(echo $username)
PASSWORD=$(echo $password)
INTERVAL=$(echo $interval)

$NOIP_EXEC -C -u $USERNAME -p $PASSWORD -U $INTERVAL
$NOIP_EXEC -d

check_noip_running() {
  pid=$(ps -ef | grep "$NOIP_EXEC" | grep -v grep | tr -s ' ' | cut -d ' ' -f2)
  if [[ $pid != "" ]]; then
    return 0
  else
    return 1
  fi
}

while true
do
  sleep 5
  check_noip_running
  running=$?
  if [[ $running -eq 0 ]]; then
    echo "NoIP is running"
  else
    echo "NoIP is not running. Exiting"
    exit 1
  fi
done
