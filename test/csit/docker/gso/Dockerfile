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

# 02-mysq.txt

# Set up mysql
RUN yum install -y mariadb-server
RUN chsh -s /bin/bash mysql
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# 03-tomcat.txt

# Set up tomcat
ADD http://mirrors.ocf.berkeley.edu/apache/tomcat/tomcat-8/v8.5.5/bin/apache-tomcat-8.5.5.tar.gz .
RUN tar --strip-components=1 -xf apache-tomcat-8.5.5.tar.gz
ENV CATALINA_HOME /service

# 05-microservice.txt

# TODO: change to ADD latest snapshot
COPY ServiceManagerService-1.0.0-SNAPSHOT.zip .
RUN unzip -o ServiceManagerService-1.0.0-SNAPSHOT.zip
RUN chmod +x bin/{start.sh,stop.sh}
ENV APP_ROOT /service

# 09-entrypoint.txt

COPY docker-entrypoint.sh .
ENTRYPOINT /service/docker-entrypoint.sh
