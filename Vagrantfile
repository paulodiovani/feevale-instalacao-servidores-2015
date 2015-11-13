# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty32'
  config.vm.provision :shell, path: './provisioning/bootstrap.sh'

  config.vm.provider 'virtualbox' do |vb|
    vb.gui = false
    vb.memory = 512
    vb.cpus = 1
  end

  # web server
  config.vm.define :web do |web|
    web.vm.hostname = 'wile'

    web.vm.provision :file, source: './makefiles/web.make', destination: '~/Makefile'
    web.vm.provision :file, source: './dockerfiles', destination: '/tmp/dockerfiles'
    web.vm.provision :shell, inline: 'mv -bT /tmp/dockerfiles /var/dockerfiles', privileged: true
    web.vm.provision :shell, path: './provisioning/web.sh'
  end

  # database server
  config.vm.define :db do |db|
    db.vm.hostname = 'taz'

    db.vm.provision :file, source: './makefiles/db.make', destination: '~/Makefile'
    db.vm.provision :shell, path: './provisioning/db.sh'
  end
end
