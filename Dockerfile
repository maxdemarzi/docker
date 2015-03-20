FROM centos:centos7

MAINTAINER maxdemarzi <maxdemarzi@gmail.com>

# Install Oracle Java 7 (currently supported JVM)
RUN yum -y install wget tar && \
    wget --no-cookies \
         --no-check-certificate \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         "http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-linux-x64.rpm" && \
    echo "53b8513548ae527d79899902524a06e1  jdk-7u75-linux-x64.rpm" >> MD5SUM && \
    md5sum -c MD5SUM && \
    rpm -Uvh jdk-7u75-linux-x64.rpm && \
    rm -f jdk-7u75-linux-x64.rpm MD5SUM

ENV JAVA_HOME /usr/java/default

# Download Neo4j 
RUN wget http://dist.neo4j.org/neo4j-community-2.2.0-RC01-unix.tar.gz \
         -O /opt/neo4j.tar.gz
RUN tar -xvzf /opt/neo4j.tar.gz
RUN rm /opt/neo4j.tar.gz
RUN mv /neo4j-community-2.2.0-RC01/ /opt/neo4j

# Set webserver to listen on all ips
RUN sed -i "s|#org.neo4j.server.webserver.address=0.0.0.0|org.neo4j.server.webserver.address=0.0.0.0|g" /opt/neo4j/conf/neo4j-server.properties

# Expose Neo4j to the host OS:

# http
EXPOSE 7474
# https
EXPOSE 7473
# shell
EXPOSE 1337

# Add VOLUMEs to allow backup and updates of config, database, logs and plugins
VOLUME  ["/opt/neo4j/conf", "/opt/neo4j/data/graph.db", "/opt/neo4j/data/log", "/opt/neo4j/plugins"]

# Add launch file
ADD launch.sh /
RUN chmod +x /launch.sh

# Start the console
CMD ["/bin/bash", "-c", "/launch.sh"]
