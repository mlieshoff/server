#!/bin/bash

DIRECTORY=/tmp/home/gotya/server
STATUS=$DIRECTORY/status.txt
APP=$DIRECTORY/server/apps/gotya

cd $DIRECTORY/server

pwd

echo "Refresh from repositiory...."
git pull

echo "Stop server...."
if [ -f "$STATUS" ]; then
	rm $STATUS
	while true; do

		value=`cat $STATUS`
		echo "$value" > /dev/null

		if [ "$value" == "STOPPED" ]; then
			echo "Stopped server."
			break
		fi

	done
fi

cd $APP

echo "Decrypt jar..."
java -cp libs/server-1.0.jar server.FileCipher conf/key libs/gotya-encrypted.jar decode libs/gotya.jar

echo "Start server...."
java -jar libs/gotya.jar conf/key conf/token.cipher conf/config.properties conf/credentials.properties $STATUS &

exit 1