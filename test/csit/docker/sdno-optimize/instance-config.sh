sed -i "s|SDNO_OPTIMIZE_ADDRESS=.*:|SDNO_OPTIMIZE_ADDRESS=\"$SERVICE_IP:|" run.sh
sed -i "s|MSB_ADDRESS=.*|MSB_ADDRESS=$MSB_ADDR|" run.sh
cat run.sh
