#==============================================================================
# script para a geração do menu de serviços em dialog
# autor: 2sgt juscelino
# data: 03/09/2015
# data de modificacao: 23/11/2015
#==============================================================================
#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-7-oracle/bin:/usr/lib/jvm/java-7-oracle/db/bin:/usr/lib/jvm/java-7-oracle/jre/bin

dialog --stdout\
 --title 'Ativação de Serviços' \
 --separate-output \
 --checklist 'Quais serviços deseja ativar?' \
0 40 0 \
1 'Servidor de DHCP' off \
2 'Servidor de DNS' off \
3 'Servidor de SSH' on \
4 'Servidor WEB' off

#clear