#!/bin/bash


## Verificar se o nomachine esta  instalado 

	#Printar a versao do Linux Mint
	VERSION_OS=$(cat /etc/os-release | grep PRETTY_NAME= | cut -c24-28)

if [ -d /usr/NX ] && [ $VERSION_OS = 20.3 ]; then

sudo dpkg -r nomachine	
sudo /usr/NX/scripts/setup/nxserver --uninstall
sudo rm -rf /usr/NX
sudo rm -rf /usr/share/applications/NoMachine-base.desktop.bpk


cd /tmp

wget --no-proxy --user=usuario_ftp --password=senha_ftp ftp://ip_ftp/app/nomachine_8.2.3_4_amd64.deb

#dpkg -i nomachine_8.2.3_4_amd64.deb

echo "Y" | dpkg -i nomachine_8.2.3_4_amd64.deb

#Entra na pasta dos atalhos
cd /usr/share/applications

#Faz uma copia de seguraça do arquico "NoMachine-base.desktop"
cp NoMachine-base.desktop NoMachine-base.desktop.bpk

#Apaga o arquivo "NoMachine-base.desktop"
rm NoMachine-base.desktop

#Excluindo atalho no Xubuntu.18
#cd /usr/NX/bin/
#cp nxplayer nxplayer.bkp
#rm nxplayer


else
		echo "O nomachine não está instalado!"

cd /tmp

wget --no-proxy --user=usuario_ftp --password=senha_ftp ftp://ip_ftp/app/nomachine_8.2.3_4_amd64.deb

#dpkg -i nomachine_8.2.3_4_amd64.deb

echo "Y" | dpkg -i nomachine_8.2.3_4_amd64.deb

#Entra na pasta dos atalhos
cd /usr/share/applications

#Faz uma copia de seguraça do arquico "NoMachine-base.desktop"
cp NoMachine-base.desktop NoMachine-base.desktop.bpk

#Apaga o arquivo "NoMachine-base.desktop"
rm NoMachine-base.desktop

#Excluindo atalho no Xubuntu.18
#cd /usr/NX/bin/
#cp nxplayer nxplayer.bkp
#rm nxplayer

fi

