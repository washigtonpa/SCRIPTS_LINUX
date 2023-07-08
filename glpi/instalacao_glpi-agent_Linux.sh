#!/bin/bash


##Função para verificar se o GLPI esta rodando

function glpi_up
{

systemctl status glpi-agent &>/dev/null


if [ "$?" -eq 0 ]; then

##O script é encerrado caso o GLPI esteja rodando

exit;


 else
     wget --no-proxy --user=usuario_ftp --password=senha_ftp ftp://ip_ftp/scripts/glpi-agent-1.4-linux-installer.pl.tar

	sleep 5

	mv glpi-agent-1.4-linux-installer.pl.tar /tmp

	cd /tmp

	tar -vxf glpi-agent-1.4-linux-installer.pl.tar

	sleep 20

	chmod +x glpi-agent-1.4-linux-installer.pl

	./glpi-agent-1.4-linux-installer.pl --reinstall --server=http://IP_SERVIDOR_GLPI/glpi/front/inventory.php

	sleep 240

	systemctl restart glpi-agent

	sleep 15

	./glpi-agent-1.4-linux-installer.pl --runnow

	sleep 15

	systemctl restart glpi-agent

	apt remove avahi-daemon gnome-keyring -y

fi


}


##Função para instalar o GLPI
function instalacao_glpi
{

	apt remove avahi-daemon gnome-keyring -y
	wget --no-proxy --user=ftp_11rm --password=senha_ftp ftp://ip_ftp/scripts/glpi-agent-1.4-linux-installer.pl.tar

	sleep 5

	mv glpi-agent-1.4-linux-installer.pl.tar /tmp

	cd /tmp

	tar -vxf glpi-agent-1.4-linux-installer.pl.tar

	sleep 20

	chmod +x glpi-agent-1.4-linux-installer.pl

	./glpi-agent-1.4-linux-installer.pl --install --server=http://IP_SERVIDOR_GLPI/glpi/front/inventory.php

		sleep 240

	systemctl restart glpi-agent

	sleep 15

		##Rodar o inventario
	./glpi-agent-1.4-linux-installer.pl --runnow

	sleep 15

	systemctl restart glpi-agent


}


##Verificar se o ocsinventory esta instalado

if [ -d "/etc/ocsinventory/" ]; then

#Remove o ocsinventory


apt-get remove ocsinventory-agent -y

#Remover pasta do ocsinventory
rm -rf /etc/ocsinventory/


fi

	##Verificar se o GLPI esta instalado
	if [ -d "/etc/glpi-agent/" ]; then


	##Chama a função para verificar se o GLPI esta rodando
		glpi_up

	else

   ##Chama a função para instalar o GLPI
	 instalacao_glpi

	fi










