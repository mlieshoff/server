#!/bin/bash

DIRECTORY=/home/crtracker
STATUS=/home/crtracker/server/status.txt

cd $DIRECTORY/server

echo "Refresh from repositiory...."
git pull

echo "Stop server...."
if [ -f "$STATUS" ]; then
	rm $STATUS
	while true; do

		value=`cat $STATUS`
		echo "$value" > /dev/null

		if [ "$value" == "STOPPED" ]; then
			echo "Start server...."
			java -jar libs/crtracker.jar conf/key conf/config.properties conf/credentials.properties $STATUS &	   
			exit 1
		fi

	done
fi

echo "Start server...."
java -jar libs/crtracker.jar conf/key conf/config.properties conf/credentials.properties $STATUS &	   

exit 1
