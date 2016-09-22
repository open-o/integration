FROM centos:7

RUN yum -y update
RUN yum install -y java-1.8.0-openjdk-headless


WORKDIR /service

ADD https://nexus.open-o.org/service/local/artifact/maven/redirect?r=snapshots&g=org.openo.common-services.microservice-bus&a=msb-core-standalone&v=LATEST&c=linux64&e=tar.gz msb-core-standalone-1.0.0-SNAPSHOT-linux64.tar.gz
RUN tar -xf msb-core-standalone-1.0.0-SNAPSHOT-linux64.tar.gz

RUN chmod +x *.sh
RUN chmod +x {eag,openresty}/{bin,nginx/sbin,luajit}/*

ENV JAVA_HOME /usr/lib/jvm/jre

COPY docker-entrypoint.sh .
ENTRYPOINT /service/docker-entrypoint.sh
