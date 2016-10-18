#!/bin/bash
# Run as root
if [ $USER != "root" ]; then
    echo "Must be run as root"
    exit 1
fi

curl "https://gerrit.open-o.org/r/gitweb?p=integration.git;a=blob_plain;f=test/csit/vagrant/weave.service;hb=refs/heads/master" > /etc/systemd/system/weave.service
curl "https://gerrit.open-o.org/r/gitweb?p=integration.git;a=blob_plain;f=test/csit/vagrant/kubernetes.repo;hb=refs/heads/master" > /etc/yum.repos.d/kubernetes.repo

yum -y update
yum -y install docker kubelet kubeadm kubectl kubernetes-cni
systemctl enable docker && systemctl start docker
curl -L git.io/weave -o /usr/local/bin/weave
chmod a+x /usr/local/bin/weave
mkdir -p /opt/cni/bin
mkdir -p /etc/cni/net.d
systemctl enable weave
systemctl enable kubelet && systemctl start kubelet
