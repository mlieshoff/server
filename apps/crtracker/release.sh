#!/bin/bash

DIRECTORY=/home/crtracker
STATUS=/home/crtracker/server/status.txt

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

echo "Decrypt jar..."
java -cp libs/server-1.0.jar server.FileCipher conf/key libs/crtracker-ecrypted.jar code libs/crtracker.jar

echo "Start server...."
java -jar libs/crtracker.jar conf/key conf/config.properties conf/credentials.properties $STATUS &	   

exit 1