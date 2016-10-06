# Start microservice
cd bin
./start.sh
while [ ! -e ../logs/protcolstack.log ]; do
    sleep 1
done
tail -F ../logs/protcolstack.log
