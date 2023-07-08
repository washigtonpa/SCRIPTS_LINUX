
#!/bin/bash


#Colocar em modo manutenção
 	sudo -u www-data php /var/www/html/nextcloud/occ maintenance:mode --on



##Relizar o backup da pasta de configuração

	cp -Rp /var/www/html/nextcloud/  /srv/backup/nextcloud-dirbkp_`date +%d.%m.%Y`_`date +%H.%M.%S`

#Relizar o backup do banco, interativo sem pedir senha (-u 'user do banco', -p 'senha do banco', "nextclouddb" => nome do banco do nextcloud)
	mysqldump --single-transaction -u root -p<senha_do_banco> nextclouddb > /srv/backup/nextcloud-sqlbkp_`date +%d.%m.%Y`_`date +%H.%M.%S`.bak


#Tirar do modo manutenção
	sudo -u www-data php /var/www/html/nextcloud/occ maintenance:mode --off
	
	
##======================= Transferir arquivo via SCP do servidor local para o outro servidor=================================
##scp /srv/backup/nextcloud-sqlbkp_29.07.2022_15.51.23.bak root@ip_srv_destinho:/srv/backup_nextcloud_11rm

##======================= Transferir pasta e sub pastas via SCP do servidor local para o outro servidor=================================
##scp -r /srv/backup/nextcloud-dir_29.07.2022_15.51.23 root@ip_srv_destinho:/srv/backup_nextcloud_11rm


##======================= Transferir pasta e sub pastas compactado via SCP do servidor local para o outro servidor=================================
##scp -Cr /srv/backup/ root@ip_srv_destinho:/srv/backup_nextcloud_11rm