FROM centos:7

WORKDIR /service

RUN yum update -y
RUN yum install -y wget
RUN yum install -y java-1.8.0-openjdk-devel
RUN yum install -y mariadb-server
RUN yum install -y tomcat

RUN sed -i 's|/var/lib/mysql:/sbin/nologin|/var/lib/mysql:/bin/bash|' /etc/passwd

COPY fix-permissions.sh /
RUN /fix-permissions.sh /var/lib/mysql/
RUN /fix-permissions.sh /var/log/mariadb/
RUN /fix-permissions.sh /var/run/

COPY docker-entrypoint.sh /

VOLUME /var/lib/mysql

COPY start.sh /
CMD /start.sh


