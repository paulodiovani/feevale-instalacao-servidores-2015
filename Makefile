
check: vagrant-exists

vagrant-exists:
	@which vagrant > /dev/null

start: check
	vagrant up

stop: check
	vagrant halt
