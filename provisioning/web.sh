#!/bin/bash
echo "Hello! From Wile E. Coyote."

echo "Create users directory if none"
if [ ! -d /var/users ]; then
  mkdir /var/users
  chown vagrant:vagrant /var/users
fi

echo "Downloading docker images"
docker pull php:apache > /dev/null
