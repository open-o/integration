# Update MSB config
sed -i "s|msbServiceUrl:.*|msbServiceUrl: http://$MSB_ADDR|" conf/console.yml
cat conf/console.yml
