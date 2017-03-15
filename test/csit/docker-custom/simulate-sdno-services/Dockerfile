FROM centos:7

RUN sed -i 's|#baseurl=http://mirror.centos.org/centos|baseurl=http://mirrors.ocf.berkeley.edu/centos|' /etc/yum.repos.d/*.repo
RUN yum update -y
RUN yum install -y net-tools vim
RUN yum install -y wget unzip socat java-1.8.0-openjdk-headless
RUN yum makecache fast
RUN yum install -y epel-release
RUN yum install -y jq
RUN sed -i 's|#networkaddress.cache.ttl=-1|networkaddress.cache.ttl=10|' /usr/lib/jvm/jre/lib/security/java.security
ENV JAVA_HOME /usr/lib/jvm/jre

WORKDIR /service

#download moco
RUN wget https://repo1.maven.org/maven2/com/github/dreamhead/moco-runner/0.11.0/moco-runner-0.11.0-standalone.jar

#copy each list in servic folder
RUN ["/bin/mkdir", "sdnol2vpn"]
ADD sdnol2vpn/*-moco-config.json ./sdnol2vpn/

RUN ["/bin/mkdir", "sdnol3vpn"]
ADD sdnol3vpn/*-moco-config.json ./sdnol3vpn/

RUN ["/bin/mkdir", "sdnooverlay"]
ADD sdnooverlay/*-moco-config.json ./sdnooverlay/

RUN ["/bin/mkdir", "sdnoservicechain"]
ADD sdnoservicechain/*-moco-config.json ./sdnoservicechain/

RUN ["/bin/mkdir", "sdnosite"]
ADD sdnosite/*-moco-config.json ./sdnosite/

RUN ["/bin/mkdir", "sdnovpc"]
ADD sdnovpc/*-moco-config.json ./sdnovpc/

#Copy license to the docker image
COPY License.txt ./

#Copy entrypoint (start service script) to the docker image
COPY docker-entrypoint.sh ./

COPY msbRegistration_general.json ./

COPY generate_all.sh ./
COPY variables.sh ./

ADD generate_all.sh /usr/local/bin/generate_all.sh
RUN ["/usr/local/bin/generate_all.sh"]

#Setup entrypoint
ENTRYPOINT /service/docker-entrypoint.sh
