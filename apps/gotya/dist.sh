#!/bin/bash
cd ../gotya

# gradle call

cp backend/build/libs/backend-1.0.jar ../server/apps/gotya/libs/gotya.jar
cp ../server_credentials/conf/gotya/encrypted/credentials.properties ../server/apps/gotya/conf