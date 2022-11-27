#!/bin/bash

log=log_file.txt
 
# create log file or overrite if already present
printf "Log File - " > $log
 
# append date to log file
date >> $log

echo "Atualizando repositórios.." >> $log

if dnf update; 
then
    echo "Repositórios atualizados.." >> $log
else
    echo "Não foi possivel atualizar os repositórios.." >> $log
    exit 1
fi

echo "Upgradeando repositórios.." >> $log

if dnf upgrade;
then
    echo "Repositórios upgradeadas.." >> $log
else
    echo "Não foi possível upgradear os repositórios.." >> $log
    exit 1
fi

echo "-----------------------------" >> $log

echo "Instalar apps? [Y,n]"
read inputApps

if [[ $inputApps == "Y" ]];
then
    bash instalar_aplicativos.sh $log;
fi

echo "-----------------------------" >> $log

echo "Instalar ambiente dev? [Y,n]"
read input

if [[ $input == "Y" ]];
then
    echo "Path do arquivo GO baixado?"
    read pathGo

    bash instalar_ambiente_desenvolvimento.sh $log $pathGo;
fi

echo >> $log
echo >> $log
echo "Nao esqueca de ver o site https://docs.fedoraproject.org/en-US/quick-docs/configuring-xorg-as-default-gnome-session/" >> $log
echo >> $log

exit 0