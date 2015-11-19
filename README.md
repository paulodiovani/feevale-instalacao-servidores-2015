# Host 101

Web hosting infrastructure for Feevale 2015.

## Dependencies

- Vagrant

## Getting started

```console
# clone this repos
git clone https://github.com/paulodiovani/feevale-instalacao-servidores-2015.git
cd feevale-instalacao-servidores-2015

# start VMs
vagrant up
```


## Access VMs

You can access VM shell by using `vagrant ssh vm-name`

```console
# access Taz web server
vagrant ssh web

# access Wile database server
vagrant ssh db
```

For each VM you can run the `make` commands.
### Web (Wile) Makefile commands

```console
# list services running on containers
make services

# create a NGINX static server
make create-nginx

# destroy a NGINX static server
make destroy-nginx

# create a PHP/MySQL server
make create-php-mysql

# destroy a PHP/MySQL server
make destroy-php-mysql
```

### Database (Taz) Makefile commands

```console
# list services running on containers
make services

# create a PostgreSQL database
make create-postgres

# destroy a PostgreSQL database
make destroy-postgres

# create a MySQL database
make create-mysql

# destroy a MySQL database
make destroy-mysql
```

