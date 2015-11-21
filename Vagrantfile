# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.provision :shell, path: './provisioning/bootstrap.sh'

  config.vm.provider 'virtualbox' do |vb|
    vb.gui = false
    vb.memory = 768
    vb.cpus = 1
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
  end

  # web server
  config.vm.define :web do |web|
    web.vm.hostname = 'wile'

    ip = '192.168.1.128'
    web.vm.network :public_network, ip: ip

    web.vm.provision :file, source: './makefiles/web.make', destination: '~/Makefile'
    web.vm.provision :file, source: './dockerfiles', destination: '/tmp/dockerfiles'
    web.vm.provision :shell, inline: 'rm -rf /var/dockerfiles && mv -bT /tmp/dockerfiles /var/dockerfiles'
    web.vm.provision :shell, path: './provisioning/web.sh'
  end

  # database server
  config.vm.define :db do |db|
    db.vm.hostname = 'taz'

    ip = '192.168.1.129'
    db.vm.network :public_network, ip: ip

    db.vm.provision :file, source: './makefiles/db.make', destination: '~/Makefile'
    db.vm.provision :shell, path: './provisioning/db.sh'
  end
end
