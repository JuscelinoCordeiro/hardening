#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
proxima='testaConexao'

clear

while : ; do
	case "$proxima" in
		testaConexao)
			proxima='telaInicial'
			clear
			echo "\nTestando conexão com a internet"
			ping -c 5 8.8.8.8 > /dev/null
			if [ $? -eq 0 ]
			then
				clear
				echo "\nConexão com a internet estabelecida."	
				sleep 2			
				clear
				echo "\nAtualizando arquivo sources.list"
				echo "Instalando pacotes iniciais."
				sh $PWD/atualizarSourcesList.sh >> /dev/null
				sh $PWD/instalaPacotesIniciais.sh >> /dev/null
				sleep 2
				clear
			else
				proxima='*'
				echo "\nNão foi possível se conectar à internet"
				echo "Abortando execução do programa"
			fi			
		;;
				
		telaInicial)
			proxima='selServicos'
			$PWD/telaInicial_d.sh
		;;
			
		selServicos)
			proxima='*'
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
								
						sleep 3
																	
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
		#verifica se o dialog esta instalado antes de exibir a msg de saida
		menuDialog=$(dpkg --get-selections | grep dialog | awk '{print $1}')
		if [ -n $menuDialog ]
		then
			msg1="Hardenind"
			msg2="Encerrando programa."
			sh $PWD/mensagem_d.sh $msg1 $msg2
		else
			echo "janela desconhecida '$proxima'."
			echo "abortando programa..."
		fi
		sleep 2
		clear
		exit
	esac
	
#retorno=$?
#[ $retorno -eq 1 ] && proxima="$anterior" #cancelar
#[ $retorno -eq 255] && break			  #sair
	
done #fim do while