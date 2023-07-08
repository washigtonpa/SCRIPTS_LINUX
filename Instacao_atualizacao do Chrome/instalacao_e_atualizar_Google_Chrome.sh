#!/bin/bash

#Este scritp instala ou atualizar para versao 109 do google chrome
#
#

	#Verifica a versão do chrome
	versao_chrome=$(/opt/google/chrome/chrome --version | cut -c15-17) &> /dev/null
	
		#Função para atualizar_chrome
		atualizar_chrome(){

			
			echo ""
			echo "Versaão do Chrome está desatualizada......."
			echo "Removendo o Chrome atual.........."

			dpkg -r google-chrome-stable

			apt-get remove google-chrome-stable -y

			rm -rf /usr/bin/google-chrome

			cd /home/$USER/.config/

			rm -r google-chrome 

			cd /tmp
			
			### Neste caso estou usando um servidor FTP para centralizar os arquivos a ser baixados

			wget --no-proxy --user=user_ftp --password=senha_user_ftp ftp://ip_meuftp/app/google-chrome-stable_amd64.deb

			###Caso use servidor de poxy, user .desktop com a configuração do seu proxy
			wget --no-proxy --user=user_ftp --password=senha_user_ftp ftp://ip_meuftp/scripts/google-chrome.desktop

			dpkg -i google-chrome-stable_amd64.deb
			
			cp /usr/share/applications/google-chrome.desktop /usr/share/applications/google-chrome.desktop.bkp

			rm -rf /usr/share/applications/google-chrome.desktop

			cp google-chrome.desktop /usr/share/applications/

			chmod +x /usr/share/applications/google-chrome.desktop

			chmod 755 /usr/share/applications/google-chrome.desktop


			echo ""
			echo "===== ATUALIZAÇÃO CONCLUIDA, VERSÃO INSTALADA É A.."$versao_chrome 

		  
	    	}	

		##Função para instalar Chrome caso o mesmo não estaja instalado
		instalar_chome(){

			echo "===== Google Chrome não está instalado =============="
			
			cd /tmp
			
			### Neste caso estou usandoi um servidor FTP para centralizar os arquivos a ser baixados
			
			wget --no-proxy --user=user_ftp --password=senha_user_ftp ftp://ip_meuftp/app/google-chrome-stable_amd64.deb

			wget --no-proxy --user=user_ftp --password=senha_user_ftp ftp://ip_meuftp/scripts/google-chrome.desktop
			
			dpkg -i google-chrome-stable_amd64.deb

			cp /usr/share/applications/google-chrome.desktop /usr/share/applications/google-chrome.desktop.bkp

			rm -rf /usr/share/applications/google-chrome.desktop

			cp google-chrome.desktop /usr/share/applications/

			chmod +x /usr/share/applications/google-chrome.desktop

			chmod 755 /usr/share/applications/google-chrome.desktop


			echo ""
			echo "===== INSTALAÇÃO CONCLUIDA, VERSÃO INSTALADA É A.."$versao_chrome		


		}


#Verificar se Chrome esta instalado
	
if [ ! -d /opt/google ]; then

	#Chama a função instalar_chome
	instalar_chome					
	
	
     #-lt Melhor que
    elif [ $versao_chrome -lt 109 &> /dev/null ]; then
   	  	
	#Chama a função instalar_chome
	atualizar_chrome

   else
 echo "======= A VERSÃO MAIS NOVA JÁ ESTA INSTALADA NO SISTEMA, VERSÃO INSTALADA É A.."$versao_chrome	

fi

















