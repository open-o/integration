FROM centos:7

RUN yum update -y
RUN yum install -y wget unzip
RUN yum install -y java-1.8.0-openjdk-headless
RUN yum install -y mariadb-server

WORKDIR /service

RUN wget http://mirrors.ocf.berkeley.edu/apache/tomcat/tomcat-8/v8.5.5/bin/apache-tomcat-8.5.5.tar.gz
RUN tar --strip-components=1 -xvf apache-tomcat-8.5.5.tar.gz

# TODO: change to wget latest snapshot
COPY ServiceManagerService-1.0.0-SNAPSHOT.zip .
RUN unzip -o ServiceManagerService-1.0.0-SNAPSHOT.zip

# allow su mysql
RUN chsh -s /bin/bash mysql

COPY run-mysql.sh .

RUN chmod +x /service/bin/{start.sh,stop.sh}

ENV JAVA_HOME /usr/lib/jvm/jre
ENV CATALINA_HOME /service
ENV APP_ROOT /service

COPY docker-entrypoint.sh .
ENTRYPOINT /service/docker-entrypoint.sh
