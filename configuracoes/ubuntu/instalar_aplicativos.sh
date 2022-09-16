#!/bin/bash

echo "-----------"
echo "Apps"
echo "-----------"

echo
echo "Instalando wget e curl.."
echo "---------------------"
echo

if apt install wget curl;
then
    echo
    echo "Wget e curl instalados.."
else
    echo "Erro ao instalar wget e curl.."
    exit 1
fi

echo
echo "------"
echo

echo "Instalando gpg.."
echo "---------------------"
echo

if apt install gpg;
then
    echo
    echo "Gpg instalados.."
else
    echo "Erro ao instalar gpg.."
    exit 1
fi

echo
echo "------"
echo

echo "Instalando git.."
echo "---------------------"
echo

if apt install git;
then
    echo
    echo "Git instalados.."
else
    echo "Erro ao instalar git.."
    exit 1
fi

echo
echo "------"
echo

echo "Instalando oh my zsh.."
echo "---------------------"
echo

if sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
then
    echo
    echo "Oh my zsh instalado.."
else
    echo "Erro ao instalar oh my zsh.."
    exit 1
fi

echo
echo
echo "--== INSTALAR DISCORD E BRAVE PELA LOJA ==--"
echo
echo