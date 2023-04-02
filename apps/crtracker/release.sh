#!/bin/bash

source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk use java 20-oracle

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
/root/.sdkman/candidates/java/20-oracle/bin/java -Dlog4j2.formatMsgNoLookups=true -cp libs/server-1.0.jar server.FileCipher conf/key libs/crtracker-encrypted.jar decode libs/crtracker.jar

echo "Start server...."
/root/.sdkman/candidates/java/20-oracle/bin/java -Dlog4j2.formatMsgNoLookups=true -jar libs/crtracker.jar conf/key conf/config.properties conf/credentials.properties $STATUS &

exit 1