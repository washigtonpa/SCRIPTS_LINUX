#!/bin/bash


		############################################################
		# Autor: 3°Sgt Aroucha
		# Data: 19/06/2021
		# Versão: 2.0
		#Descrição: Verifica qual a versão do Linux e Instalar a impressora correspondente														
		############################################################

						
			
		#Printa o nome do sistema		
	#NONE_OS=$(cat /etc/os-release | grep PRETTY_NAME= | cut -c14-19)

		#Junta as 2 informações das variaveis acima
	#VERSION="$VERSION_OS$NONE_IG"   

     #Verificar sistema no Linux Mint
    VERSION_OS2=$(cat /etc/os-release | grep PRETTY_NAME= | cut -c24-28)

		#Printar a versao do sistema
	VERSION_OS=$(cat /etc/os-release | grep PRETTY_NAME= | cut -c21-25)	

				    
         #Quando é usado "elif" não pode usar o "else" 

			
                         
	if [ $VERSION_OS = 18.04 ] && [ -d '/etc/xfce4' ]; then

		echo "XUBUNTU 18.04 IDENTIFICADO........"; sleep 3
		
			
			#Função para Instalar outro driver Generico
			instalar_prt2(){

					###Driver Generico auternativo
				#gutenprint.5.2://pcl-g_6/expert Generic PCL 6/PCL XL Printer - CUPS+Gutenprint v5.2.13
				
				##Exluir a impressora caso a mesma tenha sido instalada com erro	
				lpadmin -x IMPRESSORA_PADRAO	

			lpadmin -p IMPRESSORA_PADRAO -E -v smb://nome_servidor_impressora/impressora_mono -m gutenprint.5.2://pcl-g_6/expert/Generic-PCL_6_PCL_XL_Printer-CUPS+Gutenprintv5.2.13.ppd -L "Impressora Kyocera M3655-Generico_2" -o printer-is-shared=false -o media=a4 -d IMPRESSORA_PADRAO

					exitstatus=$?

				if [ $exitstatus = 0 ]; then

					sudo whiptail --title "Instalaçao de Impressora - Driver Generico Alternativo" --msgbox "Impressora instalada com Sucesso, Driver Generico Alternativo !!!" 10 60
					
					else
					
					sudo whiptail --title "ERRO NA INSTALAÇÃO DA IMPRESSORA --4º TENTATIVA " --msgbox "VERIFIQUE OS LOGS DE ERRO NO TERMINAL E TENTE FAZER A INSTALAÇÃO MANUAL DO DRIVER !!!!" 15 65
					
						
				fi


			}

				
		
			##Função para instalação de impressora	apos o segundo erro
			correcao_apos_primeiro_erro(){


					apt-get -y update

					sudo dpkg --configure -a

					apt --fix-broken install -y

			lpadmin -p IMPRESSORA_PADRAO -E -v smb://nome_servidor_impressora/impressora_mono -m gutenprint.5.2://pcl-g_6_l/expert/Generic-PCL_6_PCL_XL_LF_Printer-CUPS+Gutenprintv5.2.13.ppd -L "Impressora Kyocera M3655" -o printer-is-shared=false -o media=a4 -d IMPRESSORA_PADRAO


			exitstatus=$?

			if [ $exitstatus = 0 ]; then

				sudo whiptail --title "Instalaçao de Impressora" --msgbox "Impressora instalada com Sucesso !!!" 10 60
				
				else
				
				sudo whiptail --title "ERRO NA INSTALAÇÃO DA IMPRESSORA --2º TENTATIVA " --msgbox "SERÁ FEITA CORREÇÃO DO REPOSITORIO DO PW3270 E NOVA TENTATIVA DE INSTALAÇÃO !!!!" 10 60

					comentar_repo_pw3270
					

			fi

			}

			##Função para retirar repositorio do PW3270
			comentar_repo_pw3270(){

				#Comentando linha
				sed -i '1 s/^/#/' /etc/apt/sources.list.d/home\:PerryWerneck\:pw3270.list 
				apt-get -y update
				
				lpadmin -p IMPRESSORA_PADRAO -E -v smb://nome_servidor_impressora/impressora_mono -m gutenprint.5.2://pcl-g_6_l/expert/Generic-PCL_6_PCL_XL_LF_Printer-CUPS+Gutenprintv5.2.13.ppd -L "Impressora Kyocera M3655" -o printer-is-shared=false -o media=a4 -d IMPRESSORA_PADRAO

				exitstatus=$?

				if [ $exitstatus = 0 ]; then

					sudo whiptail --title "Instalaçao de Impressora" --msgbox "Impressora instalada com Sucesso !!!" 10 60

				else

				sudo whiptail --title "ERRO NA INSTALAÇÃO DA IMPRESSORA" --msgbox "Erro Novamente na Instalação, SERÁ INSTALADO OUTRO DRIVER GENERICO !!!!" 10 60

						##Instalar outro driver generico, CHAMA FUNÇÃO AQUI
					sudo whiptail --title "ERRO NA INSTALAÇÃO DA IMPRESSORA -- 3º TENTATIVA " --msgbox "SERÁ INSTALADO OUTRO DRIVER GENERICO !!!!" 10 60

						instalar_prt2

				fi

				}	


			##Função Principal para instalar impressora
				 
				instalar_prt(){


				lpadmin -p IMPRESSORA_PADRAO -E -v smb://nome_servidor_impressora/impressora_mono -m gutenprint.5.2://pcl-g_6_l/expert/Generic-PCL_6_PCL_XL_LF_Printer-CUPS+Gutenprintv5.2.13.ppd -L "Impressora Kyocera M3655" -o printer-is-shared=false -o media=a4 -d IMPRESSORA_PADRAO


				exitstatus=$?

				if [ $exitstatus = 0 ]; then

					sudo whiptail --title "Instalaçao de Impressora" --msgbox "Impressora instalada com Sucesso !!!" 10 60


				else

				sudo whiptail --title "ERRO NA INSTALAÇÃO DA IMPRESSORA" --msgbox "Erro na Instalação, SERÁ FEITA UMA CORREÇÃO!!!" 10 60
						
						correcao_apos_primeiro_erro
					

				fi

				}
	
				

				sudo apt-get -y install python3-smbc


				sudo apt-get -y install smbclient


				exitstatus=$?

				if [ $exitstatus = 0 ]; then


					 instalar_prt
					

				#sudo whiptail --title "Instalaçao de Impressora" --msgbox "Impressora instalada com Sucesso !!!" 10 60


				else


						sudo whiptail --title "ERRO NA INSTALAÇÃO DA IMPRESSORA -- 1º TENTATIVA --" --msgbox "SERÁ FEITA UMA ATUALIAÇÃO E UMA NOVA TENTATIVA !!!" 10 60
						
								
						correcao_apos_primeiro_erro


				fi
		
				
		

	elif [ $VERSION_OS = 18.04 ]; then

		echo "UBUNTU 18.04 IDENTIFICADO........"; sleep 3
		
		
				#Função para instalar impressora no Ubuntu 18
				install_prt_Ubuntu18.04(){
					
										
					lpadmin -p IMPRESSORA_PADRAO -E -v smb://nome_servidor_impressora/impressora_mono -m gutenprint.5.2://pcl-g_6_l/expert/Generic-PCL_6_PCL_XL_LF_Printer-CUPS+Gutenprintv5.2.13.ppd -L "Impressora Kyocera M3655" -o printer-is-shared=false -o media=a4 -d IMPRESSORA_PADRAO

					
					cd /tmp

					##Criar arquivo teste
					 #touch teste.txt
					sudo cp /etc/cups/printers.conf /tmp
					chmod 777 printers.conf 	


					#Enviar pagina testa para impressora
					lp -d IMPRESSORA_PADRAO printers.conf

					echo "AGUARDE, INSTALANDO IMPRESSORA ..."; sleep 3 	


					#Remover trabalho da fila de impressão
					lprm -P IMPRESSORA_PADRAO
					
					
					#sudo service cups start
					 sudo service cups restart


					 apt-get remove okular -y

					 rm -rf /usr/share/applications/AdobeReader.desktop

					 rm -rf /opt/Adobe/

					 apt-get install evince -y
					 
					 
								exitstatus=$?
						if [ $exitstatus = 0 ]; then

						

							sudo whiptail --title "Instalação de Impressora -Ubuntu 18.04" --msgbox "Impressora Instalada com Sucesso!!" 10 60


							else

							sudo whiptail --title "ERRO NA INSTALAÇÃO DA IMPRESSORA" --msgbox "VERIFIQUE OS LOGS DE ERRO NO TERMINAL E TENTE FAZER A INSTALAÇÃO MANUAL DO DRIVER !!!!" 10 60



						fi 
					


				}
						
						
					sudo apt-get -y install python3-smbc


					sudo apt-get -y install smbclient


					exitstatus=$?

					if [ $exitstatus = 0 ]; then


						 install_prt_Ubuntu18.04
						

					#sudo whiptail --title "Instalaçao de Impressora" --msgbox "Impressora instalada com Sucesso !!!" 10 60


					else


							sudo whiptail --title "ERRO NA INSTALAÇÃO DA IMPRESSORA" --msgbox "VERIFIQUE OS LOGS DE ERRO NO TERMINAL E TENTE FAZER A INSTALAÇÃO MANUAL DO DRIVER !!!!" 10 60
							
									
			


					fi	
						
				
	

	elif [ $VERSION_OS = 14.04 ]; then

		echo "UBUNTU 14.04 IDENTIFICADO........"; sleep 3
		
		
					lpadmin -p IMPRESSORA_PADRAO -E -v smb://nome_servidor_impressora/impressora_mono -m gutenprint.5.2://pcl-g_6_l/expert/Generic-PCL_6_PCL_XL_LF_Printer-CUPS+Gutenprintv5.2.13.ppd -L "Impressora Kyocera M3655" -o printer-is-shared=false -o media=a4 -d IMPRESSORA_PADRAO

					echo "AGUARDE, INSTALANDO IMPRESSORA ..."; sleep 5 

					cd /tmp

					##Criar arquivo teste
					 #touch teste.txt
					cp /etc/cups/printers.conf /tmp
					chmod 777 printers.conf 	


					#Enviar pagina testa para impressora
					lp -d IMPRESSORA_PADRAO printers.conf

					echo "AGUARDE, INSTALANDO IMPRESSORA ..."; sleep 3 	


					#Remover trabalho da fila de impressão
					lprm -P IMPRESSORA_PADRAO

					##Parando o Cups
					 #sudo service cups stop

					##Apagando a linha
					 #sudo sed -i "/AuthInfoRequired username,password/d" /etc/cups/printers.conf

					  #echo "AGUARDE, INSTALANDO IMPRESSORA ..."; sleep 3 

					##Adicionando linha no arquivo
					 #sudo sed -i '06i\AuthInfoRequired none' /etc/cups/printers.conf
					
					
					##Startando o cups	
					 #sudo service cups start
					 sudo service cups restart

					#Instalação do Evince para imprimir pdf
					
					#Removendo leitores de pdf que não funcionan na nova impressora
					apt-get remove okular -y

					 rm -rf /usr/share/applications/AdobeReader.desktop

					 rm -rf /opt/Adobe/

					apt-get install evince -y
					
					#Verificar se ocorreu erro na instalação do evince
						exitstatus=$?
							if [ $exitstatus = 0 ]; then

						

				sudo whiptail --title "Instalação de Impressora" --msgbox "Impressora Instalada com Sucesso!!" 10 60
				sudo whiptail --title "Instalação de Impressora" --msgbox "CASO ESTEJA COM A VESÃO 4 OU 5 DO LIBREOFICCE É NECESSÁRIO ATUALIZAR PARA A VERSÃO 6!!" 10 60


						else

						sudo sed -i 's/AdobeReader/firefox/g' /usr/share/applications/defaults.list

				sudo whiptail --title "Instalação de Impressora" --msgbox "Impressora Instalada com Sucesso, FOI DEFINIDO FIREFOX COMO PROGRAMA PADRÃO PARA ABRIR PDFs!!" 10 65

				sudo whiptail --title "Instalação de Impressora" --msgbox "CASO ESTEJA COM A VESÃO 4 OU 5 DO LIBREOFICCE É NECESSÁRIO ATUALIZAR PARA A VERSÃO 6!!" 10 60


						fi 
		
		
		
		
	elif [ $VERSION_OS = 20.04 ]; then

		echo "XUBUNTU 20.04 IDENTIFICADO........"; sleep 3
		
						##Exluir nova impressora	
					lpadmin -x IMPRESSORA_PADRAO	
						
					## Instalaçao do "printer-driver-gutenprint_5.3.3-4_amd64"	
					wget --no-proxy --user=user_ftp --password=senha_user_ftp ftp://ip_meuftp/app/printer-driver-gutenprint_5.3.3-4_amd64.deb
					dpkg -i printer-driver-gutenprint_5.3.3-4_amd64.deb
					
					#apt-get install gutenprint-locales -y

					apt-get -f install -y


				#=========Funcionando V1 ================================
				lpadmin -p IMPRESSORA_PADRAO -E -v smb://nome_servidor_impressora/impressora_mono -m gutenprint.5.3://pcl-g_6/expert/Generic-PCL_6_PCL_XL_Printer-CUPS+Gutenprintv5.3.3.ppd -L "Impressora Kyocera M3655" -o printer-is-shared=false -o media=a4 -p IMPRESSORA_PADRAO

				exitstatus=$?

				if [ $exitstatus = 0 ]; then
				#Colocar a impressora como padrão apos instala-la
				lpadmin -d IMPRESSORA_PADRAO

				##Exluir ImpressoraBR
				# lpadmin -x nome_impressora


				echo "AGUARDE, INSTALANDO IMPRESSORA ..."; sleep 5 

					cd /tmp

					##Criar arquivo teste
					#touch testeimp.txt

					cp /etc/cups/printers.conf /tmp

					chmod 777 printers.conf 	
					#chmod 777 testeimp.txt

					#Enviar pagina testa para impressora
					lp -d IMPRESSORA_PADRAO printers.conf

					
					echo "AGUARDE, INSTALANDO IMPRESSORA ..."; sleep 3 	

					#Remover trabalho da fila de impressão
					lprm -P IMPRESSORA_PADRAO
					lpadmin -p IMPRESSORA_PADRAO -E
					lpadmin -p IMPRESSORA_PADRAO -E
					
					   #Parando o cups arquivo			
					   sudo service cups stop

							 
					  	#Acrescentando o conteudo na linha 10 do arquivo printers.conf                       
					   #sudo sed -i '10i\AuthInfoRequired username,password' /etc/cups/printers.conf
							
						#Subustitui o paramentro de senha	
					  sudo sed -i 's/AuthInfoRequired none/AuthInfoRequired username,password/g' /etc/cups/printers.conf
	
						
					 #Startando o cups	
					 sudo service cups start
							 
					   sudo whiptail --title "Instalaçao de Impressora" --msgbox "Impressora instalada com Sucesso !!!" 10 60
													   
									  
					 else

					sudo whiptail --title "ERRO NA INSTALAÇÃO DA IMPRESSORA" --msgbox "Instale a dependência "printer-driver-gutenprint_5.3.3-4_amd64.deb" e REPITA O PROCEDIMENTO DE INSTALAÇÃO !!!" 10 60


				fi

		

###Instalação no Mint 20.3

elif [ $VERSION_OS2 = 20.3 ]; then

		echo "LINUX MINT 20.3 IDENTIFICADO........"; sleep 3
		
						##Exluir nova impressora	
					lpadmin -x IMPRESSORA_PADRAO	
						
					## Instalaçao do "printer-driver-gutenprint_5.3.3-4_amd64"	
					wget --no-proxy --user=user_ftp --password=senha_user_ftp ftp://ip_meuftp/app/printer-driver-gutenprint_5.3.3-4_amd64.deb
					dpkg -i printer-driver-gutenprint_5.3.3-4_amd64.deb
					
					#apt-get install gutenprint-locales -y

					apt-get -f install -y


				#=========Funcionando V1 ================================
				lpadmin -p IMPRESSORA_PADRAO -E -v smb://nome_servidor_impressora/impressora_mono -m gutenprint.5.3://pcl-g_6/expert/Generic-PCL_6_PCL_XL_Printer-CUPS+Gutenprintv5.3.3.ppd -L "Impressora Kyocera M3655" -o printer-is-shared=false -o media=a4 -p IMPRESSORA_PADRAO

				exitstatus=$?

				if [ $exitstatus = 0 ]; then
				#Colocar a impressora como padrão apos instala-la
				lpadmin -d IMPRESSORA_PADRAO

				##Exluir ImpressoraBR
				# lpadmin -x nome_impressora


				echo "AGUARDE, INSTALANDO IMPRESSORA ..."; sleep 5 

					cd /tmp

					##Criar arquivo teste
					#touch testeimp.txt

					cp /etc/cups/printers.conf /tmp

					chmod 777 printers.conf 	
					#chmod 777 testeimp.txt

					#Enviar pagina testa para impressora
					lp -d IMPRESSORA_PADRAO printers.conf

					
					echo "AGUARDE, INSTALANDO IMPRESSORA ..."; sleep 3 	

					#Remover trabalho da fila de impressão
					lprm -P IMPRESSORA_PADRAO
					lpadmin -p IMPRESSORA_PADRAO -E
					lpadmin -p IMPRESSORA_PADRAO -E
					
					   #Parando o cups arquivo			
					   sudo service cups stop

							 
					  	#Acrescentando o conteudo na linha 10 do arquivo printers.conf                       
					   #sudo sed -i '10i\AuthInfoRequired username,password' /etc/cups/printers.conf
							
						#Subustitui o paramentro de senha	
					  sudo sed -i 's/AuthInfoRequired none/AuthInfoRequired username,password/g' /etc/cups/printers.conf
	
						
					 #Startando o cups	
					 sudo service cups start
							 
					   sudo whiptail --title "Instalaçao de Impressora" --msgbox "Impressora instalada com Sucesso !!!" 10 60
													   
									  
					 else

					sudo whiptail --title "ERRO NA INSTALAÇÃO DA IMPRESSORA" --msgbox "Instale a dependência "printer-driver-gutenprint_5.3.3-4_amd64.deb" e REPITA O PROCEDIMENTO DE INSTALAÇÃO !!!" 10 60


				fi




		
		#Verificar se a "VERSION_OS" esta vazia
	else

		echo "Sistema Operacional Não IDENTIFICADO........";
		
	
	fi



			
