#/bin/sh

apt-get install jq
SCRIPT_LOC=$(cd `dirname $0`; pwd)
PACKAGE_DETAIL_FILE=$1
echo $PACKAGE_DETAIL_FILE

DOWNLOADURL=$( cat $PACKAGE_DETAIL_FILE | jq -r '.downloadUrl' )
INSTALL_PATH=$( cat $PACKAGE_DETAIL_FILE | jq -r '.installPath' )
SERVICES=$( cat $PACKAGE_DETAIL_FILE | jq -r '.services[]' )


read -a SERVICESArr <<<"${SERVICES}"
SERVICESArr=($SERVICES)


echo "======= Downloading from $DOWNLOADURL ======="

wget $DOWNLOADURL -P /tmp

echo "======= Download complete ======="


echo "======Extracting into $INSTALL_PATH" 
tar -C "$INSTALL_PATH" -zxvf /tmp/openo-1.0.0-RC0-linux64.tar.gz

iterator=0
while [ "$iterator" -lt ${#SERVICESArr[@]} ]
do
    
   i=${SERVICESArr[$iterator]}  

   unzip "$INSTALL_PATH/openo-1.0.0-RC0/$i/$i-1.0.0-RC0.zip" -d $INSTALL_PATH/openo-1.0.0-RC0/$i


   chmod 777 $INSTALL_PATH/openo-1.0.0-RC0/$i/bin/*

   cd $INSTALL_PATH/openo-1.0.0-RC0/$i/bin

   ./start.sh

   iterator=`expr $iterator + 1 `

done

echo $SCRIPT_LOC
cd $SCRIPT_LOC/mocomaster

java -jar moco-runner-0.11.0-standalone.jar https -p 12307 -g main.json -https cert.jks -cert mocohttps --keystore mocohttps
