# get vm ip address
getip:
	@IP_ADDRESS=`${call getip}` && \
	echo "ip address is $$IP_ADDRESS"

# check for dependencies
check: docker-exists

docker-exists:
	@which docker > /dev/null

# list docker containers
services: check
	docker ps

define getip
	hostname -I | cut -d " " -f 2
endef
