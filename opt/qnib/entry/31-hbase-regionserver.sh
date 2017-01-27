#!/bin/bash

echo "localhost" > "${HBASE_CONF_DIR}/regionservers"
/hbase/bin/hbase-daemons.sh --config "${HBASE_CONF_DIR}" --hosts "${HBASE_CONF_DIR}/regionservers" start regionserver
