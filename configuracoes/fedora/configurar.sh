#!/bin/bash

echo "Atualizando repositórios.."

if dnf update; 
then
    echo "Repositórios atualizados.."
else
    echo "Não foi possivel atualizar os repositórios.."
    exit 1
fi

echo "Upgradeando repositórios.."

if dnf upgrade;
then
    echo "Repositórios upgradeadas.."
else
    echo "Não foi possível upgradear os repositórios.."
    exit 1
fi

echo "-----------------------------"

echo "Instalar apps? [Y,n]"
read inputApps

if [[ $inputApps == "Y" ]];
then
    sudo bash instalar_aplicativos.sh;
fi

echo "-----------------------------"

echo "Ja baixou o path do golang? [Y,n]"
read inputJa

if [[ $inputJa == "Y" ]];
then

    echo "-----------------------------"

    echo "Instalar ambiente dev? [Y,n]"
    read input

    if [[ $input == "Y" ]];
    then
        echo "Path do arquivo GO baixado?"
        read pathGo

        sudo bash instalar_ambiente_desenvolvimento.sh pathGo;
    fi

fi

echo
echo
echo "Nao esqueca de ver o site https://docs.fedoraproject.org/en-US/quick-docs/configuring-xorg-as-default-gnome-session/"
echo

exit 0