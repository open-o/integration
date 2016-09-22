#!/bin/bash

/service/startup.sh
tail -F /service/openresty/nginx/logs/error.log &
tail -F /service/eag/nginx/logs/error.log &
tail -F /service/apiroute-works/logs/application.log
