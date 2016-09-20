::Scrip written by:
::     _____  ____
:: __ / / _ )/ __/
::/ // / _  |\ \  
::\___/____/___/ 


@echo off
setlocal enabledelayedexpansion
mode con:cols=67 lines=30
::zwart/geel
color 0e
title Beveiligingssystemen System Setup v1.0

:start
cls
color 0e
goto help

:menu
set menu=
set policy=
set users=
set menu1=
set powerconfig=
set menu2=
mode con:cols=67 lines=30
color 0e
title Hoofdmenu
cls
echo.
echo          ษออออออออออออออออออออออออออออออออออออออออออออออออป
echo          บ                    Hoofdmenu                   บ
echo          ฬออออออออออออออออออออออออออออออออออออออออออออออออน
echo          บ                                                บ
echo          บ       1. Gebruikers toevoegen                  บ
echo          บ       2. Security Policy toepassen             บ
echo          บ       3. Systeem instellingen                  บ
echo          บ       4. Systeem opnieuw opstarten             บ
echo          บ       5. Help                                  บ
echo          บ                                                บ
echo          บ       6. Applicatie Sluiten                    บ
echo          บ                                                บ
echo          บ                                                บ
echo          ศออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
set /p menu="Maak je keuze: "
if "%menu%"=="1" goto addUsers
if "%menu%"=="2" goto addSecpol
if "%menu%"=="3" goto systemSettings
if "%menu%"=="4" goto restart
if "%menu%"=="5" goto help
if "%menu%"=="6" goto end
if "%menu%"==" " goto menu
goto menu

:addUsers
set menu=
set users=%~dp0\users.csv

::Check if file users.csv exists
if not exist %users% goto error_file_users
goto user_list

:user_list
::Show users from users.csv
color 0E
cls
echo.
echo De volgende gebruikers zullen worden toegevoegd:
echo.
for /f "tokens=1-4 delims=; skip=1" %%a in (%users%) do echo %%a
echo.
timeout /t 5 >nul
goto add_users

:add_users
::Add Users
cls
for /f "tokens=1-4 delims=; skip=1" %%a in (%users%) do (net user %%a %%b /add /active:yes /fullname:"%%c" /comment:"%%d" /expires:never /passwordchg:no) >nul
for /f "tokens=1-4 delims=; skip=1" %%a in (%users%) do  WMIC USERACCOUNT WHERE "Name='%%a'" SET PasswordExpires=FALSE >nul
for /f "tokens=1-4 delims=; skip=1" %%a in (%users%) do (net user %%a %%b /add /active:yes /fullname:"%%c" /comment:"%%d" /expires:never /passwordchg:no) >nul
net user Administrator  /active:yes /fullname:"Administrator" /comment:"Heijmans Beveiligingssystemen" /expires:never >nul
WMIC USERACCOUNT WHERE "Name='Administrator'" SET PasswordExpires=FALSE >nul
timeout /t 1 >nul
goto set_group

:set_group
::Set Group for Servicehut
NET LOCALGROUP "Administrators" "Servicehut" /add >nul
NET LOCALGROUP "Gebruikers" "Servicehut" /delete >nul
timeout /t 1 >nul
goto complete_msg

:complete_msg
color 0A
cls
echo.
echo De volgende gebruikers zijn succesvol toegevoegd:
echo.
for /f "tokens=1-4 delims=; skip=1" %%a in (%users%) do echo %%a
timeout /t 5 >nul
goto menu

:error_file_users
::File Users.csv not found
cls
::zwart/rood
color 0c
title ERROR
echo.
echo          ษออออออออออออออออออออออออออออออออออออออออออออออออป
echo          บ                  -- ERROR --                   บ
echo          ฬออออออออออออออออออออออออออออออออออออออออออออออออน
echo          บ                                                บ
echo          บ       Users.csv niet gevonden!                  บ
echo          บ                                                บ
echo          บ       Plaats het bestand in dezelfde map       บ
echo          บ       als het script.                          บ
echo          บ                                                บ
echo          บ                                                บ
echo          บ                                                บ
echo          ศออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
timeout /t 3 >nul
goto menu

:addSecpol
cls
color 0e
title Security Policy
echo.
echo De Security Policy wordt nu toegepast.
echo.
set policy=%~dp0\secpol.inf

::Check if file secpol.inf exists
if not exist %policy% goto error_file_policy
goto add_secpol

:add_secpol
secedit /export /DB %temp%\temp.sdb /cfg %~dp0\secpol_backup.inf /quiet >nul
secedit /configure /DB %temp%\temp.sdb /cfg %policy% /overwrite /quiet >nul
goto gpupdate

:gpupdate
::Update Group Policy
gpupdate /force >nul
goto complete_msg

:complete_msg
color 0A
cls
echo.
echo De Security Policy is succesvol toegepast.
echo.
timeout /t 5 >nul
goto menu

:error_file_policy
::File secpol.inf not found
cls
::zwart/rood
color 0c
title ERROR
echo.
echo          ษออออออออออออออออออออออออออออออออออออออออออออออออป
echo          บ                  -- ERROR --                   บ
echo          ฬออออออออออออออออออออออออออออออออออออออออออออออออน
echo          บ                                                บ
echo          บ       secpol.inf niet gevonden!                 บ
echo          บ                                                บ
echo          บ       Plaats het bestand in dezelfde map       บ
echo          บ       als het script.                          บ
echo          บ                                                บ
echo          บ                                                บ
echo          บ                                                บ
echo          ศออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
timeout /t 3 >nul
goto menu

:systemSettings
cls
color 0e
title Systeem Instellingen
set menu1=
echo.
echo          ษออออออออออออออออออออออออออออออออออออออออออออออออป
echo          บ               Systeem Instellingen             บ
echo          ฬออออออออออออออออออออออออออออออออออออออออออออออออน
echo          บ                                                บ
echo          บ       1. Firewall uitschakelen                 บ
echo          บ       2. Energiebeheer aanpassen               บ
echo          บ       3. Windows Recovery uitschakelen         บ
echo          บ       4. Windows search/index uitschakelen     บ
echo          บ       5. Windows 10 meldingen uitschakelen     บ
echo          บ                                                บ
echo          บ       6. Terug naar het Hoofdmenu              บ
echo          บ                                                บ
echo          บ                                                บ
echo          ศออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
set /p menu1="Maak je keuze: "
if "%menu1%"=="1" goto firewall
if "%menu1%"=="2" goto energy
if "%menu1%"=="3" goto recovery
if "%menu1%"=="4" goto windowsSearch
if "%menu1%"=="5" goto windows10
if "%menu1%"=="6" goto menu
if "%menu1%"==" " goto systemSettings
goto systemSettings

:firewall
cls
color 0e
title Firewall
echo.
echo De Firewall wordt nu uitgeschakeld.
echo.
netsh advfirewall set allprofiles state off >nul
color 0A
cls
echo.
echo De Firewall is succesvol uitgeschakeld.
echo.
timeout /t 3 >nul
goto systemSettings

:energy
cls
color 0e
title Energie Settings
echo.
echo Energiebeheer wordt nu aangepast.
echo.
color 0E
set powerconfig=%~dp0\scheme.pow

::Check if file scheme.pow exists
if not exist %powerconfig% goto error_energy
goto set_energy

:set_energy
powercfg -import %powerconfig% 00000000-0000-0000-0000-000000000000 >nul
powercfg -setactive 00000000-0000-0000-0000-000000000000 >nul
color 0A
cls
echo.
echo Actieve Power Schema:
echo.
powercfg -getactivescheme
echo.
timeout /t 3 >nul
goto systemSettings

:error_energy
::File scheme.pow not found
cls
::zwart/rood
color 0c
title ERROR
echo.
echo          ษออออออออออออออออออออออออออออออออออออออออออออออออป
echo          บ                  -- ERROR --                   บ
echo          ฬออออออออออออออออออออออออออออออออออออออออออออออออน
echo          บ                                                บ
echo          บ       scheme.pow niet gevonden!                 บ
echo          บ                                                บ
echo          บ       Plaats het bestand in dezelfde map       บ
echo          บ       als het script.                          บ
echo          บ                                                บ
echo          บ                                                บ
echo          บ                                                บ
echo          ศออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
timeout /t 3 >nul
goto systemSettings

:recovery
cls
color 0e
title Windows Recovery
echo.
echo Windows Reovery wordt nu uitgeschakeld.
echo.
::Disable Windows Recovery Service
sc config vss start= disabled >nul
net stop vss >nul
color 0A
cls
echo.
echo Windows Recovery is succesvol uitgeschakeld.
echo.
timeout /t 3 >nul
goto systemSettings

:windowsSearch
cls
color 0e
title Windows Search/Index
echo.
echo Windows Search/Index wordt nu uitgeschakeld.
echo.
::Disable Windows Search
sc config WSearch start= disabled >nul
color 0A
cls
echo.
echo Windows Search/Index is succesvol uitgeschakeld.
echo.
timeout /t 3 >nul
goto systemSettings

:windows10
cls
color 0e
title Windows 10
echo.
echo Windows 10 meldingen worden uitgeschakeld.
echo.
::Disable Windows 10
regedit /s HKLM\SOFTWARE\Policies\Microsoft\Windows\Gwx /v DisableGwx /t REG_DWORD /d 1 /f >nul
color 0A
cls
echo.
echo Windows 10 meldingen zijn succesvol uitgeschakeld.
echo.
timeout /t 3 >nul
goto systemSettings

:restart
cls
set menu=
set policy=
set users=
set menu1=
set powerconfig=
set menu2=
del %~dp0\users.csv /f /q >nul
del %~dp0\secpol.inf /f /q >nul
del %~dp0\scheme.pow /f /q >nul
del %~dp0\help.txt /f /q >nul
cls
color 0e
title Systeem herstarten
echo.
echo          ษออออออออออออออออออออออออออออออออออออออออออออออออป
echo          บ                Systeem herstarten              บ
echo          ฬออออออออออออออออออออออออออออออออออออออออออออออออน
echo          บ                                                บ
echo          บ       Het systeem zal over 5 sec. herstarten   บ
echo          บ                                                บ
echo          บ                                                บ
echo          ศออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
timeout /t 5 >nul
shutdown /r /t 0
exit

:help
cls
if not exist %~dp0\help.txt goto error_help
goto show_help

:show_help
mode con:cols=80 lines=70
title: Help
type %~dp0\help.txt
color 0a
echo.
echo Druk op een toets om terug te keren naar het Hoofdmenu...
pause >nul
goto menu


:error_help
::File help.txt not found
cls
::zwart/rood
color 0c
title ERROR
echo.
echo          ษออออออออออออออออออออออออออออออออออออออออออออออออป
echo          บ                  -- ERROR --                   บ
echo          ฬออออออออออออออออออออออออออออออออออออออออออออออออน
echo          บ                                                บ
echo          บ       help.txt niet gevonden!                   บ
echo          บ                                                บ
echo          บ       Plaats het bestand in dezelfde map       บ
echo          บ       als het script.                          บ
echo          บ                                                บ
echo          บ                                                บ
echo          บ                                                บ
echo          ศออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
timeout /t 3 >nul
goto menu

:end
cls
set menu=
set policy=
set users=
set menu1=
set powerconfig=
set menu2=
del %~dp0\users.csv /f /q >nul
del %~dp0\secpol.inf /f /q >nul
del %~dp0\scheme.pow /f /q >nul
del %~dp0\help.txt /f /q >nul
exit
