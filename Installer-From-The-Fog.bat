@echo off
title Installation From The Fog S3
echo Telechargement des mods en cours, ne ferme pas cette fenetre...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p = Join-Path $env:TEMP ftf_install.ps1; Invoke-WebRequest https://github.com/nini17800/from-the-fog-s3-modpack/raw/main/install.ps1 -OutFile $p -UseBasicParsing; & $p"
pause
