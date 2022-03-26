@echo off
Powershell Set-ExecutionPolicy Bypass >NUL
Powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) >NUL

rem temporary saving files under c:\temp
if not exist "C:\temp" mkdir C:\temp >NUL
xcopy toinstall.csv C:\temp /y >NUL
xcopy InstallSoftware.ps1 C:\temp /y >NUL

timeout /t 3 >NUL
cls
echo "Please do not close this window!"

start /wait Powershell c:\temp\InstallSoftware.ps1
rem Removing our CSV File. 
del C:\temp\toinstall.csv >NUL
xcopy c:\temp\install.log . /y >NUL
del c:\temp\install.log >NUL
rem Directory only gets deleted, if there are no files in it. 
rmdir C:\temp >NUL


