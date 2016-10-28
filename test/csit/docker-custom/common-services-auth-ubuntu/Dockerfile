FROM ubuntu:14.04.5

WORKDIR /service

RUN echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/juno main" > /etc/apt/sources.list.d/cloudarchive-juno.list
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
RUN apt-get install -y --force-yes ubuntu-cloud-keyring sqlite3 keystone python-keystoneclient

RUN apt-get install -y wget unzip socat curl openjdk-7-jre-headless
RUN ln -s /usr/lib/jvm/java-7-openjdk-amd64/jre /usr/lib/jvm/jre
RUN sed -i 's|#networkaddress.cache.ttl=-1|networkaddress.cache.ttl=10|' /usr/lib/jvm/jre/lib/security/java.security
ENV JAVA_HOME /usr/lib/jvm/jre


# Set up tomcat
RUN wget -q http://mirrors.ocf.berkeley.edu/apache/tomcat/tomcat-8/v8.5.5/bin/apache-tomcat-8.5.5.tar.gz && tar --strip-components=1 -xf apache-tomcat-8.5.5.tar.gz && rm -f apache-tomcat-8.5.5.tar.gz
ENV CATALINA_HOME /service

# Set up microservice
RUN wget -q -O common-services-auth-1.0.0-RC1.zip https://nexus.open-o.org/content/repositories/autorelease-1070/org/openo/common-services/auth/auth-service-deployment/1.0.0-RC1/auth-service-deployment-1.0.0-RC1.zip && unzip -q -o -B common-services-auth-1.0.0-RC1.zip && rm -f common-services-auth-1.0.0-RC1.zip
EXPOSE 8102
RUN echo Open-O 1.0.0-RC1 autorelease-1070 > VERSION

EXPOSE 5000
EXPOSE 35357

# 51-permissions.txt
RUN chmod +x bin/*.sh

RUN openssl rand -hex 10 > admin_token.txt

COPY instance-config.sh .
COPY instance-init.sh .
COPY instance-run.sh .
COPY instance-workaround.sh .
COPY docker-entrypoint.sh .
ENTRYPOINT /service/docker-entrypoint.sh

