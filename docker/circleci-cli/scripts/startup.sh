#!/usr/bin/env bash

# SYS: Set user permission for docker socket

sudo chmod 666 /var/run/docker.sock

# SYS: Make orb-cli stay running

tail -f /dev/null
