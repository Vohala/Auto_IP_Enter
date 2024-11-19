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

netsh interface ipv4 set address name=%interfaceName% static 192.148.1.119 255.255.255.0 192.148.1.1 1

netsh interface ipv4 set dns name=%interfaceName% static 8.8.8.8 primary
netsh interface ipv4 add dns name=%interfaceName% addr=4.2.2.2 index=2

netsh interface ipv4 add address name=%interfaceName% addr=192.168.0.5 mask=255.255.255.0

for /f "tokens=1" %%a in ('netsh interface ipv4 show interfaces ^| findstr /C:%interfaceName%') do set interfaceIndex=%%a

echo Interface Index: %interfaceIndex%

route -p add 0.0.0.0 mask 0.0.0.0 192.168.0.1 metric 2 if %interfaceIndex%

echo Network settings have been updated successfully.
pause
