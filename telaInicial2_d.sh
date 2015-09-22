#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-7-oracle/bin:/usr/lib/jvm/java-7-oracle/db/bin:/usr/lib/jvm/java-7-oracle/jre/bin

proxima='telaInicial'

while : ; do
	case "$proxima" in
		telaInicial)
			proxima='atualizarSourcesList'
			sh $PWD/telaInicial_d.sh
			;;
			
		atualizarSourcesList)
		proxima='atualizarSourcesList'
		anterior='telaInicial'
		
		dialog\
			--title 'Hardening'\
			--msgbox 'Configurando o arquivo sources.list'\
			5 60
		#sh $PWD/atualizarSourcesList.sh 		
		sh $PWD/testeEcho.sh 
						
		;;
			
		selServicos)
			proxima='*'
			anterior='telaInicial'
			sh $PWD/selecaoDeServicos_d.sh
			;;		
			
		*)
		echo "janela desconhecida '$proxima'."
		echo "abortando programa..."
		exit
	esac
	
retorno=$?
[ $retorno -eq 1 ] && proxima="$anterior" #cancelar
[ $retorno -eq 255] && break			  #sair
	
done #fim do while