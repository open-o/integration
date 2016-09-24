# BEGIN HEADER TEMPLATE

FROM centos:7

# Need to use rackspace mirror to work on Jenkins
RUN sed -i 's|#baseurl=http://mirror.centos.org/centos|baseurl=http://mirror.rackspace.com/CentOS|' /etc/yum.repos.d/*.repo
RUN sed -i 's|mirrorlist.*||' /etc/yum.repos.d/*.repo
RUN sed -i 's|plugins=1|plugins=0|' /etc/yum.conf
RUN yum clean all
RUN yum update -y
RUN yum install -y wget unzip java-1.8.0-openjdk-headless

# END HEADER TEMPLATE
RUN yum install -y mariadb-server


# Set up mysql
RUN chsh -s /bin/bash mysql
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql


WORKDIR /service

# Set up tomcat
ADD http://mirrors.ocf.berkeley.edu/apache/tomcat/tomcat-8/v8.5.5/bin/apache-tomcat-8.5.5.tar.gz .
RUN tar --strip-components=1 -xf apache-tomcat-8.5.5.tar.gz


# Set up microservice
ADD https://nexus.open-o.org/service/local/artifact/maven/redirect?r=snapshots&g=org.openo.common-services.driver-mgr&a=drivermanager-service-deployment&v=LATEST&e=zip DriverManagerService-1.0.0.zip
RUN unzip -o DriverManagerService-1.0.0.zip
RUN chmod +x ./bin/*.sh

ENV JAVA_HOME /usr/lib/jvm/jre
ENV CATALINA_HOME /service

COPY docker-entrypoint.sh .
ENTRYPOINT /service/docker-entrypoint.sh
