FROM centos:7

RUN yum update -y
RUN yum install -y java-1.8.0-openjdk-headless
RUN yum install -y mariadb-server
RUN yum install -y unzip

WORKDIR /service

ADD https://nexus.open-o.org/service/local/artifact/maven/redirect?r=snapshots&g=org.openo.common-tosca.catalog&a=catalog-standalone&v=LATEST&e=zip catalog-standalone-1.0.0-SNAPSHOT.zip
RUN unzip catalog-standalone-1.0.0-SNAPSHOT.zip
RUN chmod +x *.sh

# Initialize mysql
RUN chsh -s /bin/bash mysql
RUN su mysql -c "mysql_install_db --datadir=/var/lib/mysql"

ENV JAVA_HOME /usr/lib/jvm/jre

COPY docker-entrypoint.sh .
ENTRYPOINT /service/docker-entrypoint.sh
