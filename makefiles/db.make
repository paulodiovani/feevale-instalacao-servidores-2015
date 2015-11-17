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

###
# Postgres database services
###

POSTGRES_IMAGE=postgres

create-postgres: check
	@while [ -z "$$DBNAME" ]; do \
		read -r -p "Database name: " DBNAME;\
	done && \
	while [ -z "$$DBPORT" ]; do \
		read -r -p "Database port: " DBPORT;\
	done && \
	IP_ADDRESS=`${call getip}` && \
	docker run --name $$DBNAME -e POSTGRES_DB=$$DBNAME -p $$DBPORT:5432 -d $(POSTGRES_IMAGE) && \
	echo "Database $$DBNAME running on $$IP_ADDRESS and port $$DBPORT." && \
	echo "Connection URL postgres://postgres:@$$IP_ADDRESS:$$DBPORT/$$DBNAME"

destroy-postgres: check
	@while [ -z "$$DBNAME" ]; do \
		read -r -p "Database name: " DBNAME;\
	done && \
	docker stop $$DBNAME && \
	docker rm -v $$DBNAME && \
	echo "Database $$DBNAME destroyed!"

define getip
	hostname -I | cut -d " " -f 2
endef
