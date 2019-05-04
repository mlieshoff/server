#!/bin/bash

DIRECTORY=/home/crtracker/server
STATUS=$DIRECTORY/status.txt
APP=$DIRECTORY/server/apps/crtracker

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
java -cp libs/server-1.0.jar server.FileCipher conf/key libs/crtracker-encrypted.jar decode libs/crtracker.jar

echo "Start server...."
java -jar libs/crtracker.jar conf/key conf/config.properties conf/credentials.properties $STATUS &	   

exit 1