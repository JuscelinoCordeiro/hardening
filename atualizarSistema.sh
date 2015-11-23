#==============================================================================
# Este script realiza uma atualização dos pacotes e do sistema
# através dos comandos apt-get update, upgrade e dist-upgrade
# autor: 2sgt juscelino
# data: 07/10/2015
# data de modificacao: 07/10/2015
#==============================================================================
#!/bin/bash

#declaração da variavel de ambiente
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

apt-get update 2> $PWD/hardening.log
#apt-get upgrade 2> $PWD/hardening.log
#apt-get dist-upgrade 2> $PWD/hardening.log