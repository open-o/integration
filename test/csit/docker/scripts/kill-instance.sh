#!/bin/bash -v
# $1 nickname for the instance

docker kill $1
sleep 1

docker rm $1
sleep 1

