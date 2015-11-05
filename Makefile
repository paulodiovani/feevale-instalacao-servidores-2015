# check for dependencies
check: vagrant-exists

vagrant-exists:
	@which vagrant > /dev/null

# start vagrant VMs
start: check
	vagrant up

# stop vagrant VMs
stop: check
	vagrant halt

# list docker containers
services: check
	@${call vrun,\
		docker ps \
	}

# get vm ip address
getip:
	@IP_ADDRESS=`${call getip}` && \
	echo "ip address is $$IP_ADDRESS"

###
# Landing Page for Hosting services
##

LANDING_PAGE_URL=https://github.com/samuelreichert/feevale-hospedagem-web-2015.git
LANDING_PAGE_PATH=/var/landing_page
LANDING_PAGE_IMAGE=nginx
LANDING_PAGE_NAME=landing_page

create-landing-page: check
	@${call vrun,\
		sudo rm -rf $(LANDING_PAGE_PATH) && \
		sudo git clone $(LANDING_PAGE_URL) $(LANDING_PAGE_PATH) && \
		docker pull $(LANDING_PAGE_IMAGE) && \
		docker run --name $(LANDING_PAGE_NAME) -v $(LANDING_PAGE_PATH):/usr/share/nginx/html:ro -p 80:80 -d $(LANDING_PAGE_IMAGE) \
	} && \
	IP_ADDRESS=`${call getip}` && \
	echo "Server started!" && \
	echo "Please, visit http://$$IP_ADDRESS"

destroy-landing-page: check
	@${call vrun,\
		docker stop $(LANDING_PAGE_IMAGE) && \
		docker rm -v $(LANDING_PAGE_IMAGE) \
	}
	echo "Server stoped!"

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
	${call vrun,\
		docker pull $(POSTGRES_IMAGE) && \
		docker run --name $$DBNAME -e POSTGRES_DB=$$DBNAME -p $$DBPORT:5432 -d $(POSTGRES_IMAGE) \
	} && \
	echo "Database $$DBNAME running on $$IP_ADDRESS and port $$DBPORT." && \
	echo "Connection URL postgres://postgres:@$$IP_ADDRESS:$$DBPORT/$$DBNAME"

destroy-postgres: check
	@while [ -z "$$DBNAME" ]; do \
		read -r -p "Database name: " DBNAME;\
	done && \
	${call vrun,\
		docker stop $$DBNAME && \
		docker rm -v $$DBNAME \
	} && \
	echo "Database $$DBNAME destroyed!"

# Run a command on vagrant environment
# @param cmd
define vrun
	vagrant ssh core-01 -c "$1"
endef

define getip
	${call vrun,fleetctl list-machines --fields=ip --no-legend | head -n1}
endef
