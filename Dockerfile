############################################################
# Dockerfile to run an OrientDB (Graph) Container
# http://crosbymichael.com/dockerfile-best-practices.html
# http://crosbymichael.com/dockerfile-best-practices-take-2.html
############################################################

# orientdb
#
# VERSION: see `TAG`
FROM joaodubas/openjdk:latest
MAINTAINER Joao Paulo Dubas "joao.dubas@gmail.com"

ENV ORIENTDB_VERSION orientdb-community-2.1-rc5

# install orientdb
ENV ORIENTDB_URL http://www.orientechnologies.com/download.php?email=unknown@unknown.com&file=${ORIENTDB_VERSION}.tar.gz&os=linux
ADD ${ORIENTDB_URL} /usr/local/src/orientdb-community.tar.gz
RUN cd /usr/local/src \
    && tar -xzf orientdb-community.tar.gz \
    && mv ${PWD}/${ORIENTDB_VERSION} /opt/orientdb \
    && rm ${PWD}/orientdb-community.tar.gz 

#ADD https://github.com/orientechnologies/orientdb-lucene/releases/download/2.0-SNAPHOST/orientdb-lucene-2.0-SNAPSHOT-dist.jar /opt/orientdb/plugins/
ADD orientdb-server-config.xml /opt/orientdb/config/orientdb-server-config.xml
ADD hazelcast.xml /opt/orientdb/config/
Add default-distributed-db-config.json /opt/orientdb/config/
ADD recommendation-engine-1.0.jar /opt/orientdb/lib/
ADD gson-2.3.1.jar /opt/orientdb/lib/

# configure system
EXPOSE 2424
EXPOSE 2480

#ENTRYPOINT["/opt/orientdb/bin/oetl.sh"]
#CMD ["/opt/orientdb/bin/oetl.sh", "${ETL_FILE}"]
CMD ["/opt/orientdb/bin/dserver.sh"]
