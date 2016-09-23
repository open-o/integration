#!/bin/bash
# $1 nickname for the instance

docker kill $1
docker rm $1

