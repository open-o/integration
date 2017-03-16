FROM centos:7

RUN sed -i 's|#baseurl=http://mirror.centos.org/centos|baseurl=http://mirrors.ocf.berkeley.edu/centos|' /etc/yum.repos.d/*.repo
RUN yum update -y
RUN yum install -y net-tools
RUN yum install -y wget unzip socat java-1.8.0-openjdk-headless
RUN sed -i 's|#networkaddress.cache.ttl=-1|networkaddress.cache.ttl=10|' /usr/lib/jvm/jre/lib/security/java.security
ENV JAVA_HOME /usr/lib/jvm/jre

EXPOSE 8536

WORKDIR /service

#download moco
RUN wget https://repo1.maven.org/maven2/com/github/dreamhead/moco-runner/0.11.0/moco-runner-0.11.0-standalone.jar

#Copy json files to the docker image
COPY *.json ./

#Copy license to the docker image
COPY License.txt ./

#Copy entrypoint (start service script) to the docker image
COPY docker-entrypoint.sh ./

#Setup entrypoint
ENTRYPOINT /service/docker-entrypoint.sh