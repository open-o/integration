FROM centos:7

WORKDIR /service

RUN yum update -y
RUN yum install -y wget
RUN yum install -y java-1.8.0-openjdk
RUN yum install -y mariadb-server
RUN yum install -y tomcat

# allow su mysql
RUN chsh -s /bin/bash mysql

# allow su tomcat
RUN chsh -s /bin/bash tomcat

COPY run-mysql.sh .
COPY run-tomcat.sh .
COPY tomcat.conf /etc/tomcat

ENV JAVA_HOME /usr/lib/jvm/jre
ENV CATALINA_HOME /usr/share/tomcat
ENV NAME gso

