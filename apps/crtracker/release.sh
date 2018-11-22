#!/bin/bash

source ~/.dotfileprefs

echo execute psql $1

sudo -u postgres psql -U postgres -c "$1"