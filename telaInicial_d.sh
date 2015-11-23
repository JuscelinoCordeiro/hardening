#==============================================================================
# script de geração da tela inicial do programa
# autor: 2sgt juscelino
# data: 03/09/2015
# data de modificacao: 23/11/2015
#==============================================================================
#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-7-oracle/bin:/usr/lib/jvm/java-7-oracle/db/bin:/usr/lib/jvm/java-7-oracle/jre/bin
dialog\
	--title 'Hardening'\
	--infobox '\nIniciando processo de hardenização do servidor'\
	5 60
	
sleep 3