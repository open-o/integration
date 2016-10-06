# Configure MSB IP address
sed -i "s|msbAddress:.*|msbAddress: $MSB_ADDR|" conf/umc.yml
cat conf/umc.yml
