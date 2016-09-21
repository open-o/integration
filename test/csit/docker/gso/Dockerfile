FROM centos:7

WORKDIR /service

RUN yum update -y
RUN yum install -y wget
RUN yum install -y java-1.8.0-openjdk-devel
RUN yum install -y mariadb-server
RUN yum install -y tomcat

# allow su mysql
RUN sed -i 's|/var/lib/mysql:/sbin/nologin|/var/lib/mysql:/bin/bash|' /etc/passwd

# allow su tomcat
RUN sed -i 's|/usr/share/tomcat:/bin/nologin|/usr/share/tomcat:/bin/bash|' /etc/passwd

COPY run-mysql.sh .



