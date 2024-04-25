#!/bin/bash

source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk use java 21.0.3-oracle

echo create server libs...
mvn clean install
cp target/server-1.0.jar apps/crtracker/libs

echo prepare crtracker release...
cd ../crtracker
mvn clean install

echo encrypt...
java -cp ../server/libs/server-1.0.jar server.FileCipher ../server_credentials/conf/crtracker/key target/crtracker-1.0.0.jar code ../server/apps/crtracker/libs/crtracker-encrypted.jar

echo copy credentials...
cp ../server_credentials/conf/crtracker/encrypted/credentials.properties ../server/apps/crtracker/conf
