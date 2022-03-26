@echo off
Rem Setting ExectionPolicy and Installing Chocolatey.
Rem ExectionPolicy is beeing set to "restricted" (default), after the PS Script is finished.

Powershell Set-ExecutionPolicy Bypass >NUL
Powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) >NUL

cls
echo Please do not close this window!

rem Temporary saving files under C:\temp
if not exist "C:\temp" mkdir C:\temp >NUL
xcopy Install.csv C:\temp /y >NUL
xcopy InstallSoftware.ps1 C:\temp /y >NUL
timeout /t 3 >NUL
start /wait Powershell c:\temp\InstallSoftware.ps1
del C:\temp\Install.csv >NUL
xcopy C:\temp\Install.log . /y >NUL
del C:\temp\Install.log >NUL
rmdir C:\temp >NUL


