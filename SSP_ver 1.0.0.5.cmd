::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWH3eyHE/Lg9DTRaHAFiJNokV5uvHzOKGrEoYWO04NpvDztQ=
::fBE1pAF6MU+EWH3eyHE/Lg9DTRaHAFiJNokV5uvHy+OUo08RUdU2drvJ27eFKe4U1VO3O8RjhzRfgM5s
::fBE1pAF6MU+EWH3eyHE/Lg9DTRaHAFiJNokV5uvH5++LsgMJTPZf
::fBE1pAF6MU+EWH3eyHE/Lg9DTRaHAFiJNokV5uvH/OmPp0AYGvIwb+8=
::fBE1pAF6MU+EWH3eyHE/Lg9DTRaHAFiJNokV5uvH/O+EskIRGusxfu8=
::fBE1pAF6MU+EWH3eyHE/Lg9DTRaHAFiJNokV5uvH+vmCsF5TV/EpGA==
::fBE1pAF6MU+EWH3eyHE/Lg9DTRaHAFiJNokV5uvH+eWIsE8YUe47R5rI36adbuMA/CU=
::YAwzoRdxOk+EWAjk
::fBw5plQjdCuDJGqL8lYnKQlRcDexDFeJNYUj5Of84KSOoUJ9
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdFy5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpSI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJhZksaHErXXA==
::ZQ05rAF9IBncCkqN+0xwdVsFAlTMbCXvZg==
::ZQ05rAF9IAHYFVzEqQIDGys0
::eg0/rx1wNQPfEVWB+kM9LVsJDDebL3+/C/Uv7fzu/6q3sEIaRuMyGA==
::fBEirQZwNQPfEVWB+kM9LVsJDDexDAs=
::cRolqwZ3JBvQF1fEqQITIBpaSwHCL3KpErARqPv++/6OrEoONA==
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATE3kciJx5aDCaQPX60FdU=
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCuDJGqL8lYnKQlRcDexDFeJNYUj/rm1v6TX7BhTUfo6GA==
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983
::Script written by:
::     _____  ____
:: __ / / _ )/ __/
::/ // / _  |\ \  
::\___/____/___/ 


@echo off
setlocal enabledelayedexpansion
mode con:cols=67 lines=30
::zwart/geel
color 0e
title System Setup Program v1.0.0.4

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
echo          ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo          º                    Hoofdmenu                   º
echo          ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
echo          º                                                º
echo          º       1. Gebruikers toevoegen                  º
echo          º       2. Security Policy toepassen             º
echo          º       3. Systeem instellingen                  º
echo          º       4. Systeem opnieuw opstarten             º
echo          º       5. Help                                  º
echo          º                                                º
echo          º       6. Applicatie Sluiten                    º
echo          º                                                º
echo          º                                                º
echo          ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
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
echo          ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo          º                  -- ERROR --                   º
echo          ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
echo          º                                                º
echo          º       Users.csv niet gevonden!                 º
echo          º                                                º
echo          º       Plaats het bestand op dezelfde locatie   º
echo          º       als het script.                          º
echo          º                                                º
echo          º                                                º
echo          º                                                º
echo          ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
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
echo          ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo          º                  -- ERROR --                   º
echo          ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
echo          º                                                º
echo          º       secpol.inf niet gevonden!                 º
echo          º                                                º
echo          º       Plaats het bestand in dezelfde map       º
echo          º       als het script.                          º
echo          º                                                º
echo          º                                                º
echo          º                                                º
echo          ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
timeout /t 3 >nul
goto menu

:systemSettings
cls
color 0e
title Systeem Instellingen
set menu1=
echo.
echo          ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo          º               Systeem Instellingen             º
echo          ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
echo          º                                                º
echo          º       1. Firewall aanpassen                    º
echo          º       2. Energiebeheer aanpassen               º
echo          º       3. Windows Recovery uitschakelen         º
echo          º       4. Windows search/index uitschakelen     º
echo          º       5. Windows Update uitschakelen           º
echo          º       6. Windows 10 - Disable tracking         º
echo          º                                                º
echo          º       7. Terug naar het Hoofdmenu              º
echo          º                                                º
echo          º                                                º
echo          ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
set /p menu1="Maak je keuze: "
if "%menu1%"=="1" goto firewallsettings
if "%menu1%"=="2" goto energy
if "%menu1%"=="3" goto recovery
if "%menu1%"=="4" goto windowsSearch
if "%menu1%"=="5" goto windowsUpdate
if "%menu1%"=="6" goto disableWinTracking
if "%menu1%"=="7" goto menu
if "%menu1%"==" " goto systemSettings
goto systemSettings

:firewallsettings
cls
color 0e
title Firewall instellingen
set menu1=
echo.
echo          ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo          º               Systeem Instellingen             º
echo          ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
echo          º                                                º
echo          º       1. Ping (ICMP) toestaan                  º
echo          º                                                º
echo          º                                                º
echo          º                                                º
echo          º                                                º
echo          º                                                º
echo          º                                                º
echo          º       7. Terug naar het Hoofdmenu              º
echo          º                                                º
echo          º                                                º
echo          ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
set /p menu1="Maak je keuze: "
if "%menu1%"=="1" goto ping
if "%menu1%"=="7" goto menu
if "%menu1%"==" " goto firewallsettings
goto firewallsettings

:ping
cls
color 0e
title Ping toestaan
echo.
echo Ping (ICMP) toestaan
echo.
netsh advfirewall firewall set  rule name="Bestands- en printerdeling (Echoaanvraag - ICMPv4-In)" new enable=yes >nul
netsh advfirewall firewall set  rule name="File and Printer Sharing (Echo Request - ICMPv4-In)" new enable=yes >nul
::netsh advfirewall set allprofiles state off >nul
color 0A
cls
echo.
echo Ping (ICMP) is nu geopend.
echo.
timeout /t 3 >nul
goto firewallsettings

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
echo          ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo          º                  -- ERROR --                   º
echo          ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
echo          º                                                º
echo          º       scheme.pow niet gevonden!                 º
echo          º                                                º
echo          º       Plaats het bestand in dezelfde map       º
echo          º       als het script.                          º
echo          º                                                º
echo          º                                                º
echo          º                                                º
echo          ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
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


:windowsUpdate
cls
color 0e
title Windows Update
echo.
echo Windows Update wordt uitgeschakeld.
echo.
::Disable Windows Update Service
sc config wuauserv start= disabled >nul
regedit /add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 1 /f >nul
color 0A
cls
echo.
echo Windows Update is succesvol uitgeschakeld.
echo.
timeout /t 3 >nul
goto systemSettings

:disableWinTracking
start DisableWinTracking_v3.2.1.exe
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
del %~dp0\voorbeeld_users.csv /f /q >nul
del %~dp0\Changelog.txt /f /q >nul
del %~dp0\DisableWinTracking_v3.2.1.exe /f /q >nul
del %~dp0\dwt.log /f /q >nul
cls
color 0e
title Systeem herstarten
echo.
echo          ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo          º                Systeem herstarten              º
echo          ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
echo          º                                                º
echo          º       Het systeem zal over 5 sec. herstarten   º
echo          º                                                º
echo          º                                                º
echo          ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
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
echo Druk op een toets om naar het hoofdmenu te gaan
pause >nul
goto menu


:error_help
::File help.txt not found
cls
::zwart/rood
color 0c
title ERROR
echo.
echo          ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo          º                  -- ERROR --                   º
echo          ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
echo          º                                                º
echo          º       help.txt niet gevonden!                   º
echo          º                                                º
echo          º       Plaats het bestand in dezelfde map       º
echo          º       als het script.                          º
echo          º                                                º
echo          º                                                º
echo          º                                                º
echo          ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
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
del %~dp0\voorbeeld_users.csv /f /q >nul
del %~dp0\Changelog.txt /f /q >nul
del %~dp0\DisableWinTracking_v3.2.1.exe /f /q >nul
del %~dp0\dwt.log /f /q >nul
exit
