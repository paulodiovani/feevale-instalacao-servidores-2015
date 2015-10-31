# Host 101

Web hosting infrastructure for Feevale 2015.

## Dependencies

- GNU Make
- Vagrant

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

