FROM mcr.microsoft.com/windows/servercore:ltsc2022
LABEL maintainer=heywoodlh


RUN Powershell.exe -ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

ENTRYPOINT "C:\ProgramData\chocolatey\bin\choco.exe"
