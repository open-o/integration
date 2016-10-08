# Start microservice
cd bin
./start.sh
while [ ! -e ../logs/vnfmadapterservice.log ]; do
    sleep 1
done
tail -F ../logs/vnfmadapterservice.log
