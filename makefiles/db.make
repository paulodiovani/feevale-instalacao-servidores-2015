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
destroy-database: check
	@while [ -z "$$NAME" ]; do \
		read -r -p "Database name: " NAME; \
	done && \
	docker stop $$NAME ; \
	docker rm -v $$NAME && \
	echo "Database $$NAME destroyed!"

###
# Postgres database services
###

POSTGRES_IMAGE=postgres

create-postgres: check
	@while [ -z "$$DBNAME" ]; do \
		read -r -p "Database name: " DBNAME; \
	done && \
	while [ -z "$$DBPORT" ]; do \
		read -r -p "Database port: " DBPORT; \
	done && \
	IP_ADDRESS=`${call getip}` && \
	docker run --restart always \
		--name "$$DBNAME" \
		-e POSTGRES_DB="$$DBNAME" \
		-p "$$DBPORT":"5432" \
		-d $(POSTGRES_IMAGE) && \
	echo "Database $$DBNAME running on $$IP_ADDRESS and port $$DBPORT." && \
	echo "Connection URL postgres://postgres:@$$IP_ADDRESS:$$DBPORT/$$DBNAME"

destroy-postgres: destroy-database

###
# MySQL Server
###

MYSQL_IMAGE=mysql

create-mysql: check
	@while [ -z "$$DBNAME" ]; do \
		read -r -p "Database name: " DBNAME;\
	done && \
	while [ -z "$$DBPORT" ]; do \
		read -r -p "Database port: " DBPORT;\
	done && \
	IP_ADDRESS=`${call getip}` && \
	docker run --restart always \
		--name "$$DBNAME" \
		-e MYSQL_DATABASE="$$DBNAME" \
		-e MYSQL_ROOT_PASSWORD=root \
		-p "$$DBPORT":"3306" -d $(MYSQL_IMAGE) && \
	echo "Database $$DBNAME running on $$IP_ADDRESS and port $$DBPORT." && \
	echo "Connection URL mysql://root:root@$$IP_ADDRESS:$$DBPORT/$$DBNAME"

destroy-mysql: destroy-database

define getip
	hostname -I | cut -d " " -f 2
endef
