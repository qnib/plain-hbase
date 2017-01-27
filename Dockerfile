FROM qnib/alplain-jre8

# inspired by
# https://github.com/HariSekhon/Dockerfiles/tree/hbase-1.2/hbase

ARG HBASE_VERSION=1.2.4
ENV PATH=$PATH:/hbase/bin \
    HBASE_CONF_DIR=/hbase/conf/ \
    HBASE_REGIONSERVERS=localhost \
    ZK_HOST=localhost \
    HBASE_MANAGES_ZK=false

VOLUME ["/tmp/hbase-root/"]
RUN apk add --no-cache bash wget tar \
 && url="http://www.apache.org/dyn/closer.lua?filename=hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz&action=download"; \
    wget -q -t 100 --retry-connrefused -O "hbase-$HBASE_VERSION-bin.tar.gz" "$url" \
 && mkdir -p hbase-$HBASE_VERSION \
 && tar zxf hbase-$HBASE_VERSION-bin.tar.gz -C hbase-$HBASE_VERSION --strip 1 \
 && ln -sv hbase-$HBASE_VERSION hbase \
 && rm -fv hbase-$HBASE_VERSION-bin.tar.gz \
 && { rm -rf hbase/{docs,src}; : ; } \
 && apk del wget tarpk add --no-cache bash wget tar \
 && url="http://www.apache.org/dyn/closer.lua?filename=hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz&action=download"; \
    wget -q -t 100 --retry-connrefused -O "hbase-$HBASE_VERSION-bin.tar.gz" "$url" \
 && mkdir -p hbase-$HBASE_VERSION \
 && tar zxf hbase-$HBASE_VERSION-bin.tar.gz -C hbase-$HBASE_VERSION --strip 1 \
 && ln -sv hbase-$HBASE_VERSION hbase \
 && rm -fv hbase-$HBASE_VERSION-bin.tar.gz \
 && { rm -rf hbase/{docs,src}; : ; } \
 && apk del wget tar
RUN mkdir -p /hbase/logs/
COPY conf/hbase-site.xml /opt/qnib/hbase/conf/
COPY opt/qnib/entry/25-hbase-zk.sh \
     opt/qnib/entry/30-hbase-master.sh \
     opt/qnib/entry/31-hbase-regionserver.sh \
     opt/qnib/entry/32-hbase-rest.sh \
     opt/qnib/entry/33-hbase-thrift.sh \
     opt/qnib/entry/40-wait-for-hbase.sh \
     /opt/qnib/entry/
CMD ["tail", "-f", "/hbase/logs/*"]
