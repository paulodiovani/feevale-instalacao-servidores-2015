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

NAS_ADDRESS=192.168.1.130
NAS_HOMES=/export/home
USER_DIRS=/var/users

# Mount NAS user directories
mount:
	mount -t nfs $(NAS_ADDRESS):$(NAS_HOMES) $(USER_DIRS)

# Umount NAS user directories
umount:
	umount $(USER_DIRS)

# Destroy a service container
destroy-app: check
	@while [ -z "$$NAME" ]; do \
		read -r -p "Application name: " NAME;\
	done && \
	docker stop $$NAME && \
	docker rm -v $$NAME && \
	docker rmi $$NAME && \
	echo "Application $$NAME destroyed!"

###
# Creates a NGINX static site
###
create-nginx: check
	@while [ -z "$$USERDIR" ] || [ ! -d /var/users/$$USERDIR ]; do \
		read -r -p "User directory: " USERDIR; \
	done && \
	while [ -z "$$PORT" ]; do \
		read -r -p "Http port: " PORT; \
	done && \
	IP_ADDRESS=`${call getip}` && \
	if [ ! -f /var/users/$$USERDIR/Dockerfile ]; then \
		cp /var/dockerfiles/nginx.dockerfile /var/users/$$USERDIR/Dockerfile; \
	fi && \
	cd "/var/users/$$USERDIR" && \
	docker build -t "$$USERDIR" . && \
	docker run --restart always \
		--name "$$USERDIR" \
		-p "$$PORT":"80" \
		-d "$$USERDIR" && \
	echo "Server running at http://$$IP_ADDRESS:$$PORT"

destroy-nginx: destroy-app

###
# Creates a PHP/MySQL app
###
create-php-apache: check
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
	if [ ! -f /var/users/$$USERDIR/Dockerfile ]; then \
		cp /var/dockerfiles/php-apache.dockerfile /var/users/$$USERDIR/Dockerfile; \
	fi && \
	cd "/var/users/$$USERDIR" && \
	docker build -t "$$USERDIR" . && \
	docker run --restart always \
		--name "$$USERDIR" \
		-e DATABASE_URL="$$DBURL" \
		-p "$$PORT":"80" \
		-d "$$USERDIR" && \
	echo "Server running at http://$$IP_ADDRESS:$$PORT"

destroy-php-apache: destroy-app

define getip
	hostname -I | cut -d " " -f 2
endef
