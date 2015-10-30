check: vagrant-exists

vagrant-exists:
	@which vagrant > /dev/null

start: check
	vagrant up

stop: check
	vagrant halt

LANDING_PAGE_URL=https://github.com/samuelreichert/feevale-hospedagem-web-2015.git
LANDING_PAGE_PATH=/var/landing_page
LANDING_PAGE_IMAGE=nginx
LANDING_PAGE_NAME=landing_page

create-landing-page: check
	@vagrant ssh core-01 -c '\
		sudo rm -rf $(LANDING_PAGE_PATH) && \
		sudo git clone $(LANDING_PAGE_URL) $(LANDING_PAGE_PATH) && \
		docker pull $(LANDING_PAGE_IMAGE) && \
		docker run --name $(LANDING_PAGE_IMAGE) -v $(LANDING_PAGE_PATH):/usr/share/nginx/html:ro -p 80:80 -d $(LANDING_PAGE_IMAGE) \
	'

destroy-landing-page: check
	@vagrant ssh core-01 -c '\
		docker stop $(LANDING_PAGE_IMAGE) && \
		docker rm -v $(LANDING_PAGE_IMAGE) \
	'
