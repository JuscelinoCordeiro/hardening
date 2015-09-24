#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-7-oracle/bin:/usr/lib/jvm/java-7-oracle/db/bin:/usr/lib/jvm/java-7-oracle/jre/bin
#==============================================================================
# script de instalação e configuracao do ssh
# autor: st jefferson
# data de criação: 22/09/2015
# data de modificação: 23/09/2015
#==============================================================================

#remove o serviço caso o mesmo ja tenha sido instalado
apt-get remove --purge openssh-server -y > /dev/null

#faz a instalação do serviço
apt-get install openssh-server -y > /dev/null

#para o serviço para que as configurações sejam feitas
/etc/init.d/ssh stop > /dev/null

#acessao o diretorio do serviço para fazer as configurações 
cd /etc/ssh

#realiza uma cópia do arquivo de configuração
cp sshd_config sshd_config.orig

#========================================================
porta=$(dialog --stdout --title 'Definindo a porta do SSH' --inputbox 'Digite a porta a ser usada' 0 0)

#Trocando a porta
sed "s/22/$porta/g" sshd_config > testessh
#sed 's/22/53022/g' sshd_config > testessh

#desabilitando a opção de login com usuario root
sed 's/without-password/no/g' testessh > testessh1

#fazendo o backup do arquivo issue.net
mv /etc/issue.net /etc/issue.net.orig

#ditando o arquivo issue.net
echo "Acesso Remoto Monitorado" > /etc/issue.net

#habilitando o arquivo issue.net como banner do ssh
sed 's/#Banner/Banner/g' testessh1 > testessh2

#definindo o diretório dos usuarios como o caminho das chaves publicas
sed 's/#AuthorizedKeysFile/AuthorizedKeysFile/g' testessh2 > testessh3

#atribui as modificações feitas ao arquivo sshd_config
mv testessh3 sshd_config

#remove os arquivos testes
rm -rf teste*

#inicializa o serviço do SSH
/etc/init.d/ssh start > /dev/null

#limpa a tela
clear

#retorna 0 se o serviço foi startado com sucesso
#return $? 
