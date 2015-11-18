#!/bin/bash
echo "Hello! From Tasmanian Devil."

echo "Downloading docker images"
docker pull postgres > /dev/null
docker pull mysql > /dev/null
