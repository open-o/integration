# Start microservice
cd bin
./start.sh
while [ ! -e ../logs/vimadapterservice.log ]; do
    sleep 1
done
tail -F ../logs/vimadapterservice.log

