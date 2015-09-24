#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-7-oracle/bin:/usr/lib/jvm/java-7-oracle/db/bin:/usr/lib/jvm/java-7-oracle/jre/bin

proxima='preparacao'

while : ; do
	case "$proxima" in
		preparacao)
		
		$PWD/instalaPacotesIniciais.sh

		if [ $? -eq 0 ]
			then
				proxima='telaInicial'
			else
				proxima='*'
		fi
		;;
		
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
			
			echo "$servicos" | while read OPCAO
			do
			 	case $OPCAO in
			 		1)
			 			#dhcp
						echo "dhcp" >> testeLog.log
					;;
			 		
			 		2)
			 			#dns
						echo "dns" >> testeLog.log
			 		;;
			 		
			 		3)
			 			#ssh
						#echo "ssh" >> testeLog.log
						$PWD/ssh.sh
						if [ $? -eq 0 ]
							then
								dialog\
									--title 'SSH'\
									--infobox '\nServico configurado com sucesso'\
									5 60
			
								else
									dialog\
									--title 'SSH'\
									--infobox '\nOcorreu um erro na configuração do servico.'\
									5 60
						fi
								
						sleep 4
																	
			 		;;
			 		
			 		4)
			 			#web
						echo "web" >> testeLog.log
					;;
				esac
				
			 	#echo "$OPCAO" >> testeLog.log
			done
			#echo "Voce escolheu $servicos"
			#sleep 4
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