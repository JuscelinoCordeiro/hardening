#!/bin/bash
#==============================================================================
# Este script realiza um backup do arquivo de configuracao do arquivo
# sources.list e reescreve-o adionando os repositórios contrib e non-free
# autor: 2sgt juscelino
# data: 03/09/2015
# data de modificacao: 03/09/2015
#==============================================================================

AtualizarSourceslist (){
#TODO função para rescrever o sources.list

#cria uma cópia do arquivo original
cp /etc/apt/sources.list /etc/apt/sources.list.old

#cria um novo arquivo sources.list
echo '
deb http://ftp.br.debian.org/debian/ jessie main contrib non-free
deb-src http://ftp.br.debian.org/debian/ jessie main contrib non-free

deb http://security.debian.org/ jessie/updates main contrib non-free 
deb-src http://security.debian.org/ jessie/updates main contrib non-free

deb http://ftp.br.debian.org/debian/ jessie-updates main contrib non-free 
deb-src http://ftp.br.debian.org/debian/ jessie-updates main contrib non-free
' > "/etc/apt/sources.list"
}

#chamada para a função
AtualizarSourceslist