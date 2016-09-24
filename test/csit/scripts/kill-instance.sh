#!/bin/bash -v
# $1 nickname for the instance

docker logs $1
docker kill $1
docker rm $1

