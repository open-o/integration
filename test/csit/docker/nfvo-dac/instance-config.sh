# Configure MSB IP address
sed -i "s|msbAddress:.*|msbAddress: $MSB_ADDR|" conf/dac.yml
cat conf/adc.yml
