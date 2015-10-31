# Host 101

Web hosting infrastructure for Feevale 2015.

## Dependencies

- GNU Make
- Vagrant

## Getting started

```console
# clone this repos
git clone https://github.com/paulodiovani/feevale-instalacao-servidores-2015.git
cd feevale-instalacao-servidores-2015

# copy config files
cp config.rb.sample config.rb
cp user-data.sample user-data

# get a new etc token
make token

# udate discovery url on user-data file
# with the url obtained previously
vim user-data

# start VMs
make start
```

## Makefile commands

```console
# start all VMs
make start

# stop all VMs
make stop

# gets a new etcd cluster token
# see https://coreos.com/os/docs/latest/cluster-discovery.html
make token

# list services running on containers
make services

# get and publish landing page
make create-landing-page

# unpublish and remove landing page
make destroy-landing-page

# create a PostgreSQL database
make create-postgres

# destroy a PostgreSQL database
make destroy-postgres
```

