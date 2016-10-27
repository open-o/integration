# Change run script to not suppress output
sed -i 's|>.*/dev/null||' nfvo/drivers/vnfm/svnfm/zte/vmanager/run.sh
