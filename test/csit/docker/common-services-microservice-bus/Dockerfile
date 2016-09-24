# BEGIN HEADER TEMPLATE

FROM centos:7

# Need to use rackspace mirror to work on Jenkins
RUN sed -i 's|#baseurl=http://mirror.centos.org/centos|baseurl=http://mirror.rackspace.com/CentOS|' /etc/yum.repos.d/*.repo
RUN sed -i 's|mirrorlist.*||' /etc/yum.repos.d/*.repo
RUN sed -i 's|plugins=1|plugins=0|' /etc/yum.conf
RUN yum clean all
RUN yum update -y
RUN yum install -y wget unzip java-1.8.0-openjdk-headless

# END HEADER TEMPLATE


WORKDIR /service

ADD https://nexus.open-o.org/service/local/artifact/maven/redirect?r=snapshots&g=org.openo.common-services.microservice-bus&a=msb-core-standalone&v=LATEST&c=linux64&e=tar.gz msb-core-standalone-1.0.0-SNAPSHOT-linux64.tar.gz
RUN tar -xf msb-core-standalone-1.0.0-SNAPSHOT-linux64.tar.gz

RUN chmod +x *.sh

ENV JAVA_HOME /usr/lib/jvm/jre

COPY docker-entrypoint.sh .
ENTRYPOINT /service/docker-entrypoint.sh
