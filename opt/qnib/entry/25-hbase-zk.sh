#!/bin/bash

if [ "X${HBASE_MANAGES_ZK}" == "Xtrue"];then
  echo "[II] Using internal ZK"
  /hbase/bin/hbase-daemons.sh --config "${HBASE_CONF_DIR}" start zookeeper
  ZK_HOST=localhost
fi
echo "[II] Write config using: ZK_HOST=${ZK_HOST}"
cat /opt/qnib/hbase/conf/hbase-site.xml | sed -e "s/ZK_HOST/${ZK_HOST}/" > /hbase/conf/hbase-site.xml
