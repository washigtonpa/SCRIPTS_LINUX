#!/bin/sh

## OBS: Esse script leva em conta que você tem um GLPI instalado conforme recomendado pela documentação oficial, com as pastas "files" e "config" fora da pasta padrão do GLPI.
## FONTE: (https://glpi-install.readthedocs.io/en/latest/install/index.html#files-and-directories-locations)


### ====== Antes de executar este script realize as seguintes acções
###Libere o proxy, caso use
#export socks_proxy=http://ip_proxy:3128/                                         
#export https_proxy=http://ip_proxy:3128/
#export http_proxy=http://ip_proxy:3128/
#export ftp_proxy=http://ip_proxy:3128/

# 1 -  Execute o script de backup do GLPI, disponível em (https://verdanadesk.com/como-fazer-backup-do-glpi/ )
# 2 - Ronomeiar as pasta GLPI ( mv /var/www/html/glpi /var/www/html/glpi-old )

######### SUBSTITUA PELO VERSÃO ATUAL
# 3 - wget -O- https://github.com/glpi-project/glpi/releases/download/10.0.7glpi-10.0.6.tgz%20 | tar -zxvf -C /var/www/html/
#
#


####=== NESTE CASO TENHO 2 GLPI RODAND EM 2 SERVIDORES DIFERENTE #####

ip_srv=$(ifconfig | sed -n '2p' | cut -c13-26)


#Função para instalar GLPI 11RM
atualizar_glpi11rm(){

echo "#Colocar em modo manutenção:"; sleep 5
php /var/www/html/glpi/bin/console glpi:maintenance:enable

echo "#Para o cron"; sleep 5
service cron stop

echo "#Excluir arquivos da pasta glpi que foi baixada"; sleep 5

rm -rf /var/www/html/glpi/files/
rm -rf /var/www/html/glpi/config/
rm -rf /var/www/html/glpi/plugins/
rm -rf /var/www/html/glpi/marketplace

echo "#Copia pasta plugins e marketplace da pasta glpi-old"; sleep 5

cp -Rp /var/www/html/glpi-old/marketplace/ /var/www/html/glpi/
cp -Rp /var/www/html/glpi-old/plugins/ /var/www/html/glpi/

echo "#Copia o arquivo downstream.php da pasta glpi-old"; sleep 5
##Conforme (https://glpi-install.readthedocs.io/en/latest/install/index.html#files-and-directories-locations)
cp -p  /var/www/html/glpi-old/inc/downstream.php /var/www/html/glpi/inc

echo "#Permisaão na pasta do GPI"; sleep 5
chmod 755 /var/www/html/glpi/ -Rf
chown www-data. /var/www/html/glpi/ -Rf

#####TRECHO CASO TENHA CUSTUMIZADO A PASTA LOGO PARA O DA SUA EMNPRESA

echo "#Romear a pasta logo da nova pasta GLPI"; sleep 5
mv /var/www/html/glpi/pics/logos /var/www/html/glpi/pics/logos-old

echo "# Copia a pasta logos da pasta “glpi-old” para a pasta glpi"; sleep 5
cp -Rp /var/www/html/glpi-old/pics/logos/ /var/www/html/glpi/pics/

echo "#Romear o tema “flood”"; sleep 5
mv /var/www/html/glpi/css_compiled/css_palettes_flood.min.css /var/www/html/glpi/css_compiled/css_palettes_flood.min.css.original

echo "#Copiar o o tema modificado da pasta “glpi-old”"; sleep 5
cp -p /var/www/html/glpi-old/css_compiled/css_palettes_flood.min.css /var/www/html/glpi/css_compiled/


echo "##TROCA TEXTO DA TELA DO LOGIN, copia arquivos da pasta “glpi-old”"; sleep 5
mv /var/www/html/glpi/templates/pages/login.html.twig /var/www/html/glpi/templates/pages/login.html.twig.original

echo "#Copia arquivo modificado da pasta “glpi-old”"; sleep 5
cp -p /var/www/html/glpi-old/templates/pages/login.html.twig /var/www/html/glpi/templates/pages/


echo "#Retirar do modo manutenção:"; sleep 5
php /var/www/html/glpi/bin/console glpi:maintenance:disable


echo "#Iniciar o cron"; sleep 5
service cron start

}



#Função para instalar GLPI SFPC
atualizar_glpisfpc(){

echo "#Colocar em modo manutenção:"; sleep 5
php /var/www/html/glpi/bin/console glpi:maintenance:enable

echo "#Para o cron"; sleep 5 
service cron stop

echo "#Excluir arquivos da pasta glpi que foi baixada"; sleep 5

rm -rf /var/www/html/glpi/files/
rm -rf /var/www/html/glpi/config/
rm -rf /var/www/html/glpi/plugins/
rm -rf /var/www/html/glpi/marketplace

echo "#Copia pasta plugins e marketplace da pasta glpi-old"; sleep 5

cp -Rp /var/www/html/glpi-old/plugins/ /var/www/html/glpi/
cp -Rp /var/www/html/glpi-old/marketplace/ /var/www/html/glpi/

echo "#Copia o arquivo downstream.php da pasta glpi-old"; sleep 5
cp -p  /var/www/html/glpi-old/inc/downstream.php /var/www/html/glpi/inc

echo "#Permisaão na pasta do GPI"; sleep 5
chmod 755 /var/www/html/glpi/ -Rf
chown www-data. /var/www/html/glpi/ -Rf

#####TRECHO CASO TENHA CUSTUMIZADO A PASTA LOGO PARA O DA SUA EMNPRESA

echo "#Romear a pasta logo da nova pasta GLPI"; sleep 5
mv /var/www/html/glpi/pics/logos /var/www/html/glpi/pics/logos-old

echo "# Copia a pasta logos da pasta “glpi-old” para a pasta glpi"; sleep 5
cp -Rp /var/www/html/glpi-old/pics/logos/ /var/www/html/glpi/pics/

echo "#Romear o tema “icecream ” "; sleep 5
mv /var/www/html/glpi/css_compiled/css_palettes_icecream.min.css /var/www/html/glpi/css_compiled/css_palettes_icecream.min.css.original

echo "#Copiar o o tema modificado da pasta “glpi-old” "; sleep 5
cp -p /var/www/html/glpi-old/css_compiled/css_palettes_icecream.min.css /var/www/html/glpi/css_compiled/


##echo "TROCA TEXTO DA TELA DO LOGIN, copia arquivos da pasta “glpi-old” "; sleep 5
#mv /var/www/html/glpi/templates/pages/login.html.twig /var/www/html/glpi/templates/pages/login.html.twig.original

#echo "Copia arquivo modificado da pasta “glpi-old” "; sleep 5
#cp -p /var/www/html/glpi-old/templates/pages/login.html.twig /var/www/html/glpi/templates/pages/


echo "#Retirar do modo manutenção:"; sleep 5
php /var/www/html/glpi/bin/console glpi:maintenance:disable


echo "#Iniciar o cron"; sleep 5
service cron start

}




#Verificar qual é o servidor, 11rm ou SFPC
if [ $ip_srv = ip_sevidor1   ]; then

        echo "GLPI da 11RM"
		atualizar_glpi11rm

     #
    elif [ $ip_srv = ip_sevidor2 ]; then

       echo "GLPI da SFPC"
	   atualizar_glpisfpc

   else

 echo "SERVIDOR NÃO HABILITADO PARA ATUALIZAR O GLPI"

fi
