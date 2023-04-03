#!/bin/bash

source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk use java 20-oracle

echo create server libs...
mvn clean install
cp target/server-1.0.jar apps/gotya/libs

echo prepare gotya release...
cd ../gotya

echo copy production keys to ids.xml
cp ../server_credentials/conf/gotya/ids.xml android/res/values/ids.xml

echo create backend jar...
cd backend
mvn clean install
cd ..

echo create game jars...
# ./gradlew clean assemble

echo TODO gradle call to assemble apk
# ./gradlew android:assemble

echo encrypt...
java -cp ../server/libs/server-1.0.jar server.FileCipher ../server_credentials/conf/gotya/key backend/target/backend-1.0.0.jar code ../server/apps/gotya/libs/gotya-encrypted.jar

echo copy credentials...
cp ../server_credentials/conf/gotya/encrypted/credentials.properties ../server/apps/gotya/conf