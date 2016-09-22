FROM centos:7

RUN yum update -y
RUN yum install -y java-1.8.0-openjdk-headless
RUN yum install -y mariadb-server


# Set up mysql
RUN chsh -s /bin/bash mysql
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql


WORKDIR /service

# Set up microservice
ADD https://nexus.open-o.org/service/local/artifact/maven/redirect?r=snapshots&g=org.openo.common-tosca.inventory&a=standalone&v=LATEST&e=tar.gz&c=linux64 openo-commontosca-inventory-1.0.0-SNAPSHOT-linux64.tar.gz
RUN tar -xf openo-commontosca-inventory-1.0.0-SNAPSHOT-linux64.tar.gz
RUN chmod +x *.sh


ENV JAVA_HOME /usr/lib/jvm/jre

COPY docker-entrypoint.sh .
ENTRYPOINT /service/docker-entrypoint.sh
