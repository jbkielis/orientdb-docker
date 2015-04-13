############################################################
# Dockerfile to run an OrientDB (Graph) Container in distributed mode
# http://crosbymichael.com/dockerfile-best-practices.html
# http://crosbymichael.com/dockerfile-best-practices-take-2.html
############################################################

FROM vagas/orientdb-base:2.0

MAINTAINER Ronie Uliana (ronie.uliana@gmail.com)

ENV ORIENTDB_VERSION 2.0

# Config files
ADD orientdb-server-config.xml /opt/orientdb/config/orientdb-server-config.xml
ADD default-distributed-db-config.json /opt/orientdb/config/default-distributed-db-config.json
ADD hazelcast.xml /opt/orientdb/config/hazelcast.xml

# Empty database
ADD databases/production /opt/orientdb/databases/production

# Binary protocol port
EXPOSE 2424

# HTTP port (studio and REST)
EXPOSE 2480

# Multicast port (for Hazelcast)
EXPOSE 2434/udp
EXPOSE 2434/tcp

# Set the user to run OrientDB daemon
USER root

ENV ORIENTDB_NODE_NAME=c1

# Default command when starting the container
CMD ["/bin/bash", "-c", "/opt/orientdb/bin/server.sh -Ddistributed=true"]
