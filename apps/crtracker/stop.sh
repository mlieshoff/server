#!/bin/bash

source ~/.serverprefs

/usr/local/bin/program &
echo $! > /var/run/program.pid