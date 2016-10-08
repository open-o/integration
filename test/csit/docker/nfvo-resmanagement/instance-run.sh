# Start microservice
cd bin
./start.sh
while [ ! -e ../logs/resmanagement.log ]; do
    sleep 1
done
tail -F ../logs/resmanagement.log
