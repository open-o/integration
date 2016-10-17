#!/usr/bin/env python

import sys, csv, subprocess, os, string

version = "1.0.0-RC0"

root = subprocess.check_output(["git", "rev-parse", "--show-toplevel"]).rstrip()
path = "{}/test/csit/kubernetes".format(root)

f = open("{}/autorelease/binaries.csv".format(root), "r")

reader = csv.DictReader(f)
outfile = open( "{}/openo.yaml".format(path), "w" )

for row in reader:
    print row["filename"]
    
    image = row["filename"]
    port = row["port"]
    
    outfile.write(string.Template("""
---
apiVersion: v1
kind: Service
metadata:
  name: ${image}
  labels:
    app: ${image}
spec:
  selector:
    app: ${image}
  type: NodePort
  ports:
  - port: ${port}
    targetPort: ${port}
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: ${image}
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: ${image}
    spec:
      containers:
      - name: ${image}
        image: openoint/${image}
        env:
        - name: GET_HOSTS_FROM
          value: dns
        - name: MSB_ADDR
          value: common-services-msb:80
        ports:
        - containerPort: ${port}
""").substitute(locals()))

outfile.close()
f.close()
