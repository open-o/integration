FROM centos:7

WORKDIR /service

RUN yum -y update
RUN yum install -y wget
RUN yum install -y java-1.8.0-openjdk-devel
RUN wget --content-disposition 'https://nexus.open-o.org/service/local/artifact/maven/redirect?r=snapshots&g=org.openo.common-services.microservice-bus&a=msb-core-standalone&v=LATEST&c=linux64&e=tar.gz' -O msb-core-standalone-1.0.0-SNAPSHOT-linux64.tar.gz
RUN tar xfz msb-core-standalone-1.0.0-SNAPSHOT-linux64.tar.gz

ENTRYPOINT /service/startup.sh; tail -F /service/apiroute-works/logs/application.log
