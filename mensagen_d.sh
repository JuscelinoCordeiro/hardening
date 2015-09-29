#==============================================================================
# script de mensagem generico utilizando o dialog
# o script recebe 2 parametros, sendo o primeiro o titulo
# e o segundo a mensagem propriamente dita
# autor: 2sgt juscelino
# data: 24/09/2015
# data de modificacao: 24/09/2015
#==============================================================================
#!/bin/bash

#declaração da variavel de ambiente
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#chamada para o dialog
dialog\
	--title "$1"\
	--infobox "\n$2"\
	5 60
	
#aguarda 3 segundos
sleep 3

#limpa a tela
clear