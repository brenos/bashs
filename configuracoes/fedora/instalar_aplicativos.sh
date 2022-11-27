#!/bin/bash

echo "-----------" >> $1
echo "Apps" >> $1
echo "-----------" >> $1

echo "Instalando wget, curl e gpg.." >> $1

if dnf install wget curl gpg;
then
    echo "Wget, curl e gpg instalados.." >> $1
else
    echo "Erro ao instalar wget, curl e gpg.." >> $1
    exit 1
fi

echo >> $1
echo "------" >> $1
echo >> $1

echo "Instalando zsh.." >> $1

if dnf install zsh \
&& usermod -s "$(which zsh)" $USER;
then
    echo "Zsh instalado.." >> $1
else
    echo "Erro ao instalar zsh.." >> $1
fi

echo >> $1
echo "------" >> $1
echo >> $1

echo "Instalando Discord.." >> $1

if dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
&& dnf update \
&& dnf install discord;
then
    echo "Discord instalado.." >> $1
else
    echo "Erro ao instalar Discord.." >> $1
fi

echo >> $1
echo "------" >> $1
echo >> $1

echo "Instalando Brave.." >> $1

if dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/ \
&& rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc \
&& dnf install brave-browser -y;
then
    echo "Bravo instalado.." >> $1
else
    echo "Erro ao instalar Brave.." >> $1
fi