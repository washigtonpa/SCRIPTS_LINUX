##### Use uma GPO para instalar o glpi.msi e outra para rodar este "bat"
#
#
#

# Verificar se tem OCS Inventory esta instalado e desinstala

if exist "%ProgramFiles(x86)%\OCS Inventory Agent" (
	"%ProgramFiles(x86)%\OCS Inventory Agent\uninst.exe" /S
)

if exist "%ProgramFiles%\OCS Inventory Agent" (
	"%ProgramFiles%\OCS Inventory Agent\uninst.exe" /S
)


#Camilho correto de acordo com os testes "http://ip_glpi/glpi/front/inventory.php"

reg add hklm\software\GLPI-Agent /v server /t REG_SZ /d http://ip_glpi/glpi/front/inventory.php/ /f


reg add hklm\software\GLPI-Agent /v httpd-trust /t REG_SZ /d 127.0.0.1/32,ip_glpi/32 /f
reg add hklm\software\GLPI-Agent /v tag /t REG_SZ /d %COMPUTERNAME% /f
reg add hklm\software\GLPI-Agent /v delaytime /t REG_SZ /d 300 /f
reg add hklm\software\GLPI-Agent /v force /t REG_SZ /d 1 /f

net stop glpi-agent
net start glpi-agent


