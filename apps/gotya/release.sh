#!/bin/bash

source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk use java 20-oracle

DIRECTORY=/home/gotya/server
STATUS=$DIRECTORY/gotya.pid
APP=$DIRECTORY/server/apps/gotya

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
/root/.sdkman/candidates/java/20-oracle/bin/java -Dlog4j2.formatMsgNoLookups=true -cp libs/server-1.0.jar server.FileCipher conf/key libs/gotya-encrypted.jar decode libs/gotya.jar

echo "Start server...."
/root/.sdkman/candidates/java/20-oracle/bin/java -Dlog4j2.formatMsgNoLookups=true -jar libs/gotya.jar conf/payment-production.p12 conf/key conf/token.cipher conf/config.properties conf/credentials.properties $STATUS &

exit 1