FROM centos:7

RUN yum clean all
RUN yum update -y
RUN yum install -y java-1.8.0-openjdk-headless
RUN yum install -y mariadb-server
RUN yum install -y unzip

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
