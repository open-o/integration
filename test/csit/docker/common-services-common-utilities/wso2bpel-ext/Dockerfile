FROM centos:7

RUN yum -y update
RUN yum install -y java-1.8.0-openjdk-headless
RUN yum install -y unzip
RUN yum install -y wget


WORKDIR /service

RUN wget --header "Referer:http://wso2.com/products/business-process-server/" https://product-dist.wso2.com/products/business-process-server/3.6.0/wso2bps-3.6.0.zip
RUN unzip wso2bps-3.6.0.zip

ADD https://nexus.open-o.org/service/local/artifact/maven/redirect?r=snapshots&g=org.openo.common-services.common-utilities.wso2bpel-ext&a=standalone&v=LATEST&c=linux64&e=tar.gz openo-commonservice-commonutilities-wso2bpel-ext-1.0.0-SNAPSHOT-linux64.tar.gz
RUN tar -xf openo-commonservice-commonutilities-wso2bpel-ext-1.0.0-SNAPSHOT-linux64.tar.gz

RUN chmod +x *.sh

ENV JAVA_HOME /usr/lib/jvm/jre

COPY docker-entrypoint.sh .
ENTRYPOINT /service/docker-entrypoint.sh
