@echo off
if "%1"=="/help" goto help
if "%1"=="--help" goto help
git clone --depth 1 --branch=qb/new-bundle https://github.com/QbProg/oce-win-bundle.git
if "%1"=="" goto end
goto end
:help
echo "Usage : FetchBundle.bat <version>"
:end