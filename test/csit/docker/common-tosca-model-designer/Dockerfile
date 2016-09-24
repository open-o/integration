# 01-basebuild.txt

FROM centos:7

# Need to use rackspace mirror to work on Jenkins
RUN sed -i 's|#baseurl=http://mirror.centos.org/centos|baseurl=http://mirror.rackspace.com/CentOS|' /etc/yum.repos.d/*.repo
RUN sed -i 's|mirrorlist.*||' /etc/yum.repos.d/*.repo
RUN sed -i 's|plugins=1|plugins=0|' /etc/yum.conf

RUN yum clean all
RUN yum update -y
RUN yum install -y wget unzip java-1.8.0-openjdk-headless
ENV JAVA_HOME /usr/lib/jvm/jre

WORKDIR /service

# 05-microservice.txt

# Set up microservice
ADD https://nexus.open-o.org/service/local/artifact/maven/redirect?r=snapshots&g=org.openo.common-tosca.model-designer.modeldesigner.distribution&a=modeldesigner-standalone&v=LATEST&e=tar.gz&c=linux.gtk.x86_64 modeldesigner-standalone-1.0.0-SNAPSHOT-linux.gtk.x86_64.tar.gz
RUN tar --strip-components=1 -xf modeldesigner-standalone-1.0.0-SNAPSHOT-linux.gtk.x86_64.tar.gz
RUN chmod +x *.sh

# 09-entrypoint.txt

COPY docker-entrypoint.sh .
ENTRYPOINT /service/docker-entrypoint.sh
