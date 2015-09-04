#!/bin/bash
#==================================================
# script de configuracao do arquivo sources.list
# e atualizacao de pacotes
# autor: 2sgt juscelino
# data: 03/09/2015
# data de modificacao: 03/09/2015
#==================================================
atualizarSourceslist (){
cp /etc/apt/sources.list /etc/apt/sources.list.old

echo '
#==========================================================
# arquivo souces.list editato por hardenizacao em 03/09/2015
# autor: 2sgt juscelino
# data de criacao: 03/09/2015
# data de modificacao: 03/09/2015
#==========================================================
' > "/etc/apt/sources.list"
#' > "/home/thoth/workspace/hardening/testeLog.log"

echo '
deb http://ftp.br.debian.org/debian/ jessie main contrib non-free
deb-src http://ftp.br.debian.org/debian/ jessie main contrib non-free

deb http://security.debian.org/ jessie/updates main contrib non-free 
deb-src http://security.debian.org/ jessie/updates main contrib non-free

deb http://ftp.br.debian.org/debian/ jessie-updates main contrib non-free 
deb-src http://ftp.br.debian.org/debian/ jessie-updates main contrib non-free
' > "/etc/apt/sources.list"
#' > "/home/thoth/workspace/hardening/testeLog.log"

}
atualizarSourceslist