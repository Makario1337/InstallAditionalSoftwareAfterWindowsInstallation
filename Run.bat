@echo off

rem This Script installs Chocolatey and sets the Powershell Execution Policy to bypass.

rem Powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

rem temporary saving files under c:\temp
if not exist "C:\temp" mkdir C:\temp >NUL
xcopy toinstall.csv C:\temp /y >NUL

start /wait Powershell ./InstallSoftware.ps1
rem Removing our CSV File. 
del C:\temp\toinstall.csv >NUL
rem Directory only gets deleted, if there are no files in it. 
rmdir C:\temp >NUL

exit