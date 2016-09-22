FROM centos:7

RUN yum update -y
RUN yum install -y java-1.8.0-openjdk-headless


WORKDIR /service

# Set up microservice
ADD https://nexus.open-o.org/service/local/artifact/maven/redirect?r=snapshots&g=org.openo.common-tosca.model-designer.modeldesigner.distribution&a=modeldesigner-standalone&v=LATEST&e=tar.gz&c=linux.gtk.x86_64 modeldesigner-standalone-1.0.0-SNAPSHOT-linux.gtk.x86_64.tar.gz
RUN tar --strip-components=1 -xf modeldesigner-standalone-1.0.0-SNAPSHOT-linux.gtk.x86_64.tar.gz
RUN chmod +x *.sh


ENV JAVA_HOME /usr/lib/jvm/jre

COPY docker-entrypoint.sh .
ENTRYPOINT /service/docker-entrypoint.sh
