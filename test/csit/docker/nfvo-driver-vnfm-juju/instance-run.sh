# Start microservice
cd bin
./start.sh
while [ ! -e ../logs/jujuvnfmadapterservice.log ]; do
    sleep 1
done
tail -F ../logs/jujuvnfmadapterservice.log
