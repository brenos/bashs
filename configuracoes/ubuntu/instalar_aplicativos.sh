#!/bin/bash

echo "-----------"
echo "Apps"
echo "-----------"

echo
echo "Instalando wget, curl e apt-transport-https.."
echo "---------------------"
echo

if apt install wget curl apt-transport-https;
then
    echo
    echo "Wget, curl e apt-transport-https instalados.."
else
    echo "Erro ao instalar wget, curl e apt-transport-https.."
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
fi

echo
echo "------"
echo

echo "Instalando zsh.."
echo "---------------------"
echo

if apt install zsh;
then
    echo
    echo "Zsh instalados.."
else
    echo "Erro ao instalar zsh.."
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
fi

echo
echo "------"
echo

echo "Instalando Brave Browser.."
echo "---------------------"
echo

if curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list \
&& apt update \
&& apt install brave-browser;
then
    echo 
    echo "Brave instalado.."
else
    echo "Erro ao instalar Brave.."
fi

echo
echo "------"
echo

echo "Instalando Discord.."
echo "---------------------"
echo

if apt install $1;
then
    echo 
    echo "Discord instalado.."
else
    echo "Erro ao instalar Discord.."
fi