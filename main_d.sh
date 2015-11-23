#==============================================================================
# script de principal, tem a função de ser um controlador para
# chamar outros scripts e receber o retorno dos mesmos
# autor: 2sgt juscelino
# data: 03/09/2015
# data de modificacao: 23/11/2015
#==============================================================================
#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
proxima='testaConexao'

clear

while : ; do
	case "$proxima" in
		testaConexao)
			proxima='telaInicial'
			clear
			echo "\nVerificando condições para execução do programa"
			sleep 1
			clear
			echo "\nTestando conexão com a internet"
			ping -c 5 8.8.8.8  >> $PWD/hardening.log
			if [ $? -eq 0 ]
			then
				clear
				echo "\nConexão com a internet estabelecida."	
				sleep 2	
				echo "\nIniciando processo de hardenização do servidor."	
				sleep 2
				clear
				echo "\nAtualizando arquivo sources.list"
				echo "Instalando pacotes iniciais."
				sh $PWD/atualizarSourcesList.sh  >> $PWD/hardening.log
				sh $PWD/atualizarSistema.sh >> $PWD/hardening.log
				sh $PWD/instalaPacotesIniciais.sh  >> $PWD/hardening.log
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
						msg1="Hardening"
						msg2="Instalação do SSH"
						sh $PWD/mensagem_d.sh "$msg1" "$msg2"
						
						$PWD/ssh.sh
						if [ $? -eq 0 ]
							then
								msg1="SSH"
								msg2="Serviço configurado com sucesso"
								sh $PWD/mensagem_d.sh "$msg1" "$msg2"
							else
								msg1="SSH"
								msg2="Serviço configurado com sucesso"
								sh $PWD/mensagem_d.sh "$msg1" "$msg2"
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
			msg1="Hardening"
			msg2="Encerrando programa."
			sh $PWD/mensagem_d.sh "$msg1" "$msg2"
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