#!/bin/bash
echo "Hello! From Wile E. Coyote."

echo "Create users directory if none"
if [ ! -d /var/users ]; then
  mkdir /var/users
  chown vagrant:vagrant /var/users
fi

echo "Downloading docker images"
docker pull nginx > /dev/null
docker pull node:0.12-onbuild > /dev/null
docker pull node:4-onbuild > /dev/null
docker pull node:5-onbuild > /dev/null
docker pull php:apache > /dev/null
