#!/bin/bash
echo "Hello!"

# Install Docker
echo "Updating repositories..." &&
apt-get -qq update &&
echo "Installing docker..." &&
apt-get -qq install docker.io > /dev/null &&
docker --version
