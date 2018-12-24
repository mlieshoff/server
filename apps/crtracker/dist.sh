#!/bin/bash
cd ../crtracker
mvn clean install
cp target/crtracker-1.0.0-shaded.jar ../server/apps/crtracker/libs/crtracker.jar
cp ../server_credentials/conf/crtracker/encrypted/credentials.properties ../server/apps/crtracker/conf