#!/bin/bash

log=log_file.txt
 
# create log file or overrite if already present
printf "Log File - " > $log
 
# append date to log file
date >> $log

echo "Atualizando repositórios.." >> $log

if apt update; 
then
    echo "Repositórios atualizados.." >> $log
else
    echo "Não foi possivel atualizar os repositórios.." >> $log
fi

echo "Upgradeando repositórios.." >> $log

if apt upgrade;
then
    echo "Repositórios upgradeadas.." >> $log
else
    echo "Não foi possível upgradear os repositórios.." >> $log
fi

echo "-----------------------------" >> $log

echo "Instalar apps? [s,N]"
read inputApps

if [[ $inputApps == "s" ]];
then
    echo "Path + arquivo .deb Discord baixado?"
    read pathDiscord 
    bash instalar_aplicativos.sh $log $pathDiscord;
fi

echo "-----------------------------"

echo "Instalar ambiente de desenvolvimento? [s,N]"
read input

if [[ $input == "s" ]];
then
    bash instalar_ambiente_desenvolvimento.sh $log;
fi

echo >> $1
echo >> $1
echo "--== INSTALAR TRELO PELA LOJA ==--" >> $1
echo "--== CONFIGURAR GIT TOKEN ==--" >> $1
echo "--== CONFIGURAR ZSH COMO SHELL PADRAO ==--" >> $1
echo >> $1
echo >> $1

exit 0