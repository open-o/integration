# Start microservice
cd bin
./start.sh
while [ ! -e ../logs/catalina.out ]; do
    sleep 1
done
tail -F ../logs/catalina.out
