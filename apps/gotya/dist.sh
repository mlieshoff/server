#!/bin/bash

echo create server libs...
mvn clean install
cp target/server-1.0.jar apps/gotya/libs

echo prepare gotya release...
cd ../gotya

echo copy production keys to ids.xml
cp ../server_credentials/conf/gotya/ids.xml android/res/values/ids.xml

echo create jars...
./gradlew jar

echo TODO gradle call to assemble apk
# ./gradlew android:assemble

echo encrypt...
java -cp ../server/libs/server-1.0.jar server.FileCipher ../server_credentials/conf/gotya/key backend/build/libs/backend-1.0.jar code ../server/apps/gotya/libs/gotya-encrypted.jar

echo copy credentials...
cp ../server_credentials/conf/gotya/encrypted/credentials.properties ../server/apps/gotya/conf