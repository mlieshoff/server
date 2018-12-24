#!/bin/bash

DIRECTORY=/home/crtracker
STATUS=/home/crtracker/status.txt

cd /tmp

cp crtracker.tar /home/crtracker/

cd /home/crtracker

if [ -f "$STATUS" ]; then
	rm $STATUS
	while true; do

		value=`cat $STATUS`
		echo "$value" > /dev/null

		if [ "$value" == "STOPPED" ]; then
			echo "stopped."
			tar -xvf crtracker.tar 
			java -jar libs/crtracker.jar conf/key conf/config.properties conf/credentials.properties status.txt &	   
			exit 1
		fi

	done
fi

tar -xvf crtracker.tar 
java -jar libs/crtracker.jar conf/key conf/config.properties conf/credentials.properties status.txt &	   

exit 1
