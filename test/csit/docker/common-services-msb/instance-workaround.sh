# workaround to specific IP of model designer
if [ -z "$MODEL_DESIGNER_IP" ]; then
    export MODEL_DESIGNER_IP=`hostname -i`
fi
echo "MODEL_DESIGNER_IP=$MODEL_DESIGNER_IP"
sed -i "35s/127\.0\.0\.1/$MODEL_DESIGNER_IP/" apiroute/ext/initServices/msb.json
sed -i "47s/127\.0\.0\.1/$MODEL_DESIGNER_IP/" apiroute/ext/initServices/msb.json
cat apiroute/ext/initServices/msb.json
