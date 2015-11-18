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

# Destroy a service container
destroy-service: check
	@while [ -z "$$NAME" ]; do \
		read -r -p "Service name: " NAME;\
	done && \
	docker stop $$NAME && \
	docker rm -v $$NAME && \
	echo "Service $$NAME destroyed!"

###
# Createa a PHP/Apache app
###

PHP_IMAGE=php:apache

create-php: check
	@while [ -z "$$USERDIR" ] || [ ! -d /var/users/$$USERDIR ]; do \
		read -r -p "User directory: " USERDIR; \
	done && \
	while [ -z "$$DBURL" ]; do \
		read -r -p "Database url: " DBURL; \
	done && \
	while [ -z "$$PORT" ]; do \
		read -r -p "Http port: " PORT; \
	done && \
	IP_ADDRESS=`${call getip}` && \
	docker run --name $$USERDIR -e DATABASE_URL=$$DBURL -p $$PORT:80 \
		-v /var/users/$$USERDIR:/var/www/html -d $(PHP_IMAGE) && \
	echo "Server running at http://$$IP_ADDRESS:$$PORT"

destroy-php: destroy-service

define getip
	hostname -I | cut -d " " -f 2
endef
