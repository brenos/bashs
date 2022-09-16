#!/bin/bash

echo "-----------"
echo "Apps"
echo "-----------"

echo "Instalando wget, curl e gpg.."

if dnf install wget curl gpg;
then
    echo "Wget, curl e gpg instalados.."
else
    echo "Erro ao instalar wget, curl e gpg.."
    exit 1
fi

echo
echo "------"
echo

echo "Instalando zsh.."

if dnf install zsh \
&& usermod -s "$(which zsh)" $USER;
then
    echo "Zsh instalado.."
else
    echo "Erro ao instalar zsh.."
    exit 1
fi

echo
echo "------"
echo

echo "Instalando oh my zsh.."

if sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
then
    echo "Oh my zsh instalado.."
else
    echo "Erro ao instalar oh my zsh.."
    exit 1
fi

echo
echo "------"
echo

echo "Instalando Discord.."

if dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
&& dnf update \
&& dnf install discord;
then
    echo "Discord instalado.."
else
    echo "Erro ao instalar Discord.."
    exit 1
fi

echo
echo "------"
echo

echo "Instalando Brave.."

if rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc; \
 dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/ \
&& dnf install brave-browser -y;
then
    echo "Bravo instalado.."
else
    echo "Erro ao instalar Brave.."
    exit 1
fi