#!/bin/bash

echo "Atualizando repositórios.."

if apt update; 
then
    echo "Repositórios atualizados.."
else
    echo "Não foi possivel atualizar os repositórios.."
    exit 1
fi

echo "Upgradeando repositórios.."

if apt upgrade;
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
    bash instalar_aplicativos.sh;
fi

echo "-----------------------------"

echo "Ja baixou o golang e o dbeaver? [Y,n]"
read inputJa

if [[ $inputJa == "Y" ]];
then

    echo "-----------------------------"

    echo "Instalar ambiente de desenvolvimento? [Y,n]"
    read input

    if [[ $input == "Y" ]];
    then
        echo "Path + arquivo do arquivo GO baixado?"
        read pathGo

        echo "Path + arquivo do arquivo DBeaver baixado?"
        read pathDbeaver

        bash instalar_ambiente_desenvolvimento.sh $pathGo $pathDbeaver;
    fi

fi

echo
echo
echo "--== INSTALAR DISCORD E BRAVE PELA LOJA ==--"
echo "--== INSTALAR TRELO PELA LOJA ==--"
echo "--== CONFIGURAR GIT TOKEN ==--"
echo "--== CONFIGURAR ZSH COMO SHELL PADRAO ==--"
echo
echo

exit 0