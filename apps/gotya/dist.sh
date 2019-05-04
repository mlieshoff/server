#!/bin/bash

echo create server libs...
mvn clean install
cp target/server-1.0.jar libs

echo prepare gotya release...
cd ../gotya

# TODO gradle call

echo encrypt...
java -cp ../server/libs/server-1.0.jar server.FileCipher ../server_credentials/conf/gotya/key backend/build/libs/backend-1.0.jar code ../server/apps/gotya/libs/gotya.jar

echo copy credentials...
cp ../server_credentials/conf/gotya/encrypted/credentials.properties ../server/apps/gotya/conf