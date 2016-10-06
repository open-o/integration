# fix path issue to catalina.sh in bin/start.sh
sed -i 's|catalina.sh|$CATALINA_HOME/bin/catalina.sh|' ./bin/{start.sh,stop.sh}

# proxy connection to MSB
socat TCP-LISTEN:8080,fork TCP:$MSB_ADDR &

