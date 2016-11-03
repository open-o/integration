sed -i "s|SDNO_DRIVER_CT_TE_ADDRESS=.*:|SDNO_DRIVER_CT_TE_ADDRESS=\"$SERVICE_IP:|" run.sh
sed -i "s|MSB_ADDRESS=.*|MSB_ADDRESS=$MSB_ADDR|" run.sh
cat run.sh
