#==============================================================================
# script para testar se existe conexão com a internet
# realizando 5 ping para o servidor DNS público do google
# autor: 2sgt juscelino
# data: 03/09/2015
# data de modificacao: 23/11/2015
#==============================================================================
#!/bin/bash

ping -c 5 8.8.8.8 >> $PWD/hardening.log

#if [ $? -eq 0 ]
then
	echo "rede ok"
	#return 10
else
	#return 20
	echo "sem rede"
fi