#!/bin/bash

DIRECTORY=/home/crtracker/server
STATUS=$DIRECTORY/crtracker.pid
APP=$DIRECTORY/server/apps/crtracker

cd $DIRECTORY/server

pwd

echo "Refresh from repositiory...."
git pull

echo "Stop server...."
if [ -f "$STATUS" ]; then
  kill $(cat $STATUS)
  while true; do
    if [ -f "$STATUS" ]; then
      echo "Waiting ..."
    else
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