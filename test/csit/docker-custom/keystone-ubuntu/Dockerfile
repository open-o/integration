FROM ubuntu:14.04.5

RUN echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/juno main" > /etc/apt/sources.list.d/cloudarchive-juno.list
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
RUN apt-get install -y --force-yes ubuntu-cloud-keyring sqlite3 keystone python-keystoneclient

EXPOSE 5000
EXPOSE 35357

WORKDIR /service
RUN openssl rand -hex 10 > admin_token.txt
ADD docker-entrypoint.sh .
ENTRYPOINT docker-entrypoint.sh
