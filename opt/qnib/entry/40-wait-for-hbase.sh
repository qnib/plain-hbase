#!/bin/bash

echo "[II] Wait for hbase to settle"
set -x
while [ $(find /hbase/logs/*.log |wc -l) -lt 4 ];do
  sleep 1
done
