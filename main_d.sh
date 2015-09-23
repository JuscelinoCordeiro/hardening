#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-7-oracle/bin:/usr/lib/jvm/java-7-oracle/db/bin:/usr/lib/jvm/java-7-oracle/jre/bin

proxima='telaInicial'

while : ; do
	case "$proxima" in
		telaInicial)
			proxima='testaConexao'
			$PWD/telaInicial_d.sh
			;;
			
		testaConexao)
			proxima='atualizarSourcesList'
			#conexao = sh $PWD/testaConexao.sh
			
			ping -c 5 8.8.8.8 > /dev/null
			
			(echo 20 ; sleep 1
			echo 40 ; sleep 1
			echo 60 ; sleep 1
			echo 80 ; sleep 1
			echo 100 ; sleep 1) | dialog\
									--title 'Teste de conexão'\
									--gauge '\nTestando a conexão com a internet'\
										8 40 60
								
			if [ $? -eq 0 ]
				then
					dialog\
						--title 'Teste de conexão'\
						--infobox '\nConexão de rede ok'\
						5 60
					
					sleep 3
			else
				proxima=*
				dialog\
					--title 'Teste de conexão'\
					--infobox '\nSem conexão de rede - Abortando.......'\
					5 60
					
				sleep 3
			fi
			;;
				
		atualizarSourcesList)
		proxima='selServicos'
		#anterior='telaInicial'
		
		dialog\
			--title 'Hardening'\
			--infobox '\nConfigurando o arquivo sources.list'\
			5 60
			
		sleep 4	
		#sh $PWD/atualizarSourcesList.sh 		
		#sh $PWD/testeEcho.sh 
						
		;;
			
		selServicos)
			proxima='*'
			#anterior='telaInicial'
			servicos=$($PWD/selecaoDeServicos_d.sh)
			echo "Voce escolheu $servicos"
			;;		
			
		*)
		msg="Janela desconhecida '$proxima'."
		dialog\
			--title 'Hardening'\
			--infobox "\n'$msg'\nAbortando programa..."\
			5 60
						
			sleep 3
		#echo "janela desconhecida '$proxima'."
		#echo "abortando programa..."
		clear
		exit
	esac
	
retorno=$?
[ $retorno -eq 1 ] && proxima="$anterior" #cancelar
[ $retorno -eq 255] && break			  #sair
	
done #fim do while