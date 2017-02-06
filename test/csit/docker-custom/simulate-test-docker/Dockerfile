#
# ./moco/Dockerfile
#

# docker run -i -t -v /root/openo/integration/bootstrap/start-service-script/mocomaster:/var/lib/moco  -p 18009:18009 -p 18008:18008 --entrypoint /bin/bash moco  

FROM centos:7

RUN sed -i 's|#baseurl=http://mirror.centos.org/centos|baseurl=http://mirrors.ocf.berkeley.edu/centos|' /etc/yum.repos.d/*.repo
RUN yum update -y

RUN yum install -y wget unzip socat java-1.8.0-openjdk-headless
RUN sed -i 's|#networkaddress.cache.ttl=-1|networkaddress.cache.ttl=10|' /usr/lib/jvm/jre/lib/security/java.security
ENV JAVA_HOME /usr/lib/jvm/jre

WORKDIR /service

COPY cert.jks ./cert.jks

# Set up tomcat
RUN wget -q https://repo1.maven.org/maven2/com/github/dreamhead/moco-runner/0.11.0/moco-runner-0.11.0-standalone.jar \
    && mkdir -p /var/lib/moco \
    && printf "[]" > /var/lib/moco/main.json \


EXPOSE 18009
#CMD ["java", "-jar", "moco-runner-0.11.0-standalone.jar", "http", "-p", "18009", "-g", "/var/lib/moco/main.json", "&"]
#RUN java -jar moco-runner-0.11.0-standalone.jar http -p 18009 -g /var/lib/moco/main.json &

EXPOSE 18008
#CMD ["java", "-jar", "moco-runner-0.11.0-standalone.jar", "https", "-p", "18008", "-g", "/var/lib/moco/main.json", "-https", "cert.jks",  "-cert", "mocohttps", "--keystore",  "mocohttps", "&"]

#Setup Robot Framework
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
RUN python get-pip.py
RUN pip install robotframework

# 90-entrypoint.txt

RUN yum clean all

COPY instance-config.sh .
COPY instance-init.sh .
COPY instance-run.sh .
COPY instance-workaround.sh .
COPY docker-entrypoint.sh .

RUN chmod +x *.sh

ENTRYPOINT /service/docker-entrypoint.sh

COPY LICENSE ./OPENO_LICENSE
