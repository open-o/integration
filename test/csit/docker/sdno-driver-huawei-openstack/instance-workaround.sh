# proxy connection to MSB
socat TCP-LISTEN:8080,fork TCP:$MSB_ADDR &

# fix broken start/stop scripts
sed -i '1i#!/bin/bash'
dos2unix bin/{start.sh,stop.sh}
