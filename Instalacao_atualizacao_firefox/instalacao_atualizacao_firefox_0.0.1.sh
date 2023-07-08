#!/bin/bash

#Este scritp instala ou atualizar para versao 111.0.1 do Firefox

#Verifica a versão atual do Firefox
	versao_firefox=$(su eb -c "firefox --version" | cut -c17-19) &> /dev/null


#Função para atualizar_firefox
		atualizar_firefox(){

#Removendo a vensao atual		
sudo apt-get remove -y firefox*

sudo rm -Rf /usr/lib/firefox

sudo rm -Rf /usr/bin/firefox

sudo rm -Rf /opt/firefox/

#Mudan para o iretorio temporário
cd /tmp

### Neste caso estou usando um servidor FTP para centralizar os arquivos a ser baixados 

#Baixando o arquivo do FTP
wget --no-proxy --user=user_ftp --password=senha_user_ftp ftp://ip_meuftp/app/firefox-111.0.1.tar.bz2

sudo tar -jxvf firefox-111.0.1.tar.bz2

mv firefox /opt

#Criando link simbolico
sudo ln -s /opt/firefox/firefox /usr/bin/firefox

#Baixando o arquivo de confiuração do proxy
wget --no-proxy --user=user_ftp --password=senha_user_ftp ftp://ip_meuftp/scripts/mozilla.cfg
cp mozilla.cfg /opt/firefox/mozilla.cfg

#Baixando o arquivo de confiuração do proxy
wget --no-proxy --user=user_ftp --password=senha_user_ftp ftp://ip_meuftp/scripts/local-settings.js
cp local-settings.js /opt/firefox/defaults/pref/local-settings.js

versao_firefox=$(su eb -c "firefox --version" | cut -c17-19) &> /dev/null

###Verifica se existeo atalho do firefox
if [ ! -e /usr/share/applications/firefox.desktop ]; then

	echo "============ATALHO DO FIREFOX NÃO ENCONTRADO, COPIANDO ATALHO.......!!!!"

sleep 5

	wget --no-proxy --user=user_ftp --password=senha_user_ftp ftp://10.133.184.17/scripts/firefox.desktop
	
    chmod 755 firefox.desktop
	
	chmod +x firefox.desktop	

    mv firefox.desktop /usr/share/applications/
	
	
    else


    echo "============ATALHO DO FIREFOX OK.......!!!!"


 fi



echo "======INSTALAÇÃO CONCLUIDA COM SUCESSO!!!VERSÃO INSTALADA É A..."$versao_firefox

}


#Verificar a versão do firefox instalada

		   #-lt Melhor que
if [ $versao_firefox -lt 111 &> /devnull ]; then

echo "====== NAVEGADOR DESATUALIZADO, INSTALANDO A VERSÃO 111 DO FIREFOX ======"

sleep 5

	#Chama a função para o firefox
	atualizar_firefox

	else

echo "======= A VERSÃO MAIS NOVA JÁ ESTA INSTALADA NO SISTEMA, VERSÃO INSTALADA É A..."$versao_firefox	


fi
