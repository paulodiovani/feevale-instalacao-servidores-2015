FIRST_ADDRESS=172.17.8.101

check: vagrant-exists

vagrant-exists:
	@which vagrant > /dev/null

start: check
	vagrant up

stop: check
	vagrant halt

# List docker containers
services:
	@${call vrun,\
		docker ps \
	}

LANDING_PAGE_URL=https://github.com/samuelreichert/feevale-hospedagem-web-2015.git
LANDING_PAGE_PATH=/var/landing_page
LANDING_PAGE_IMAGE=nginx
LANDING_PAGE_NAME=landing_page

create-landing-page: check
	@${call vrun,\
		sudo rm -rf $(LANDING_PAGE_PATH) && \
		sudo git clone $(LANDING_PAGE_URL) $(LANDING_PAGE_PATH) && \
		docker pull $(LANDING_PAGE_IMAGE) && \
		docker run --name $(LANDING_PAGE_IMAGE) -v $(LANDING_PAGE_PATH):/usr/share/nginx/html:ro -p 80:80 -d $(LANDING_PAGE_IMAGE) \
	}
	echo "Server started!"
	echo "Please, visit http://$(FIRST_ADDRESS)"

destroy-landing-page: check
	@${call vrun,\
		docker stop $(LANDING_PAGE_IMAGE) && \
		docker rm -v $(LANDING_PAGE_IMAGE) \
	}
	echo "Server stoped!"

POSTGRES_IMAGE=postgres

create-postgres: check
	@while [ -z "$$DBNAME" ]; do \
		read -r -p "Database name: " DBNAME;\
	done && \
	${call vrun,\
		docker pull $(POSTGRES_IMAGE) && \
		docker run --name $$DBNAME -e POSTGRES_DB=$$DBNAME -d $(POSTGRES_IMAGE) \
	}

destroy-postgres: check
	@while [ -z "$$DBNAME" ]; do \
		read -r -p "Database name: " DBNAME;\
	done && \
	${call vrun,\
		docker stop $$DBNAME && \
		docker rm -v $$DBNAME \
	}

# Run a command on vagrant environment
define vrun
	vagrant ssh core-01 -c "$1"
endef
