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

# Mount user directories from NAS
make mount

# Umount user directories from NAS
make umount

# create a NGINX static server
make create-nginx

# destroy a NGINX static server
make destroy-nginx

# create a PHP/Apache server
make create-php-apache

# destroy a PHP/Apache server
make destroy-php-apache
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

## Creating new application

1. Criar user no NAS e ajuste de permissões
1. Passar os dados de conexão FTP para cliente (com o caminho da pasta)
1. Criar BD no Taz com o nome que o cliente pediu
1. Passar os dados de acesso pro cliente
1. Cria aplicação no Wile (`sudo make create-php-apache`)
1. Ajusta nginxconf com o novo dominio
1. Recria nginx conf (`make destroy-nginx` e `sudo make create-nginx`)
1. Pede acesso ao dominio pro professor
