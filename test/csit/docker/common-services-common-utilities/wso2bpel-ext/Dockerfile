#
# This file was auto-generated; do not modify manually.  Instead, modify the component
# templates and then run gen-all-dockerfiles.sh to re-generate.
#
# ./common-services-common-utilities/wso2bpel-ext Dockerfile
#
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

RUN wget --header "Referer:http://wso2.com/products/business-process-server/" https://product-dist.wso2.com/products/business-process-server/3.6.0/wso2bps-3.6.0.zip
RUN unzip wso2bps-3.6.0.zip

ADD https://nexus.open-o.org/service/local/artifact/maven/redirect?r=snapshots&g=org.openo.common-services.common-utilities.wso2bpel-ext&a=standalone&v=LATEST&c=linux64&e=tar.gz openo-commonservice-commonutilities-wso2bpel-ext-1.0.0-SNAPSHOT-linux64.tar.gz
RUN tar -xf openo-commonservice-commonutilities-wso2bpel-ext-1.0.0-SNAPSHOT-linux64.tar.gz
RUN chmod +x *.sh

# 09-entrypoint.txt

COPY docker-entrypoint.sh .
ENTRYPOINT /service/docker-entrypoint.sh
