@echo off
:-------------------------------------
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:-------------------------------------

set interfaceName="Wi-Fi"

netsh interface ipv4 set address name=%interfaceName% source=dhcp

netsh interface ipv4 set dnsservers name=%interfaceName% source=dhcp

ipconfig /release "%interfaceName%"
ipconfig /renew "%interfaceName%"

echo IPv4 and DNS settings have been set to obtain automatically.
pause
