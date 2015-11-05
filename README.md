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

# start VMs
make start
```

## Makefile commands

```console
# start all VMs
make start

# stop all VMs
make stop

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

