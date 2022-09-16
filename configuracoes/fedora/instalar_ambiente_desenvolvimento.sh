#!/bin/bash

echo "-----------"
echo "Apps Dev"
echo "-----------"

echo "Instalando VS Code.."

if rpm --import https://packages.microsoft.com/keys/microsoft.asc \
&& sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' \
&& dnf check-update \
&& dnf install code;
then
    echo "VS Code instalado.."
else
    echo "Erro ao instalar VS Code.."
    exit 1
fi

echo
echo "------"
echo

echo "Instalando GO.."

if rm -rf /usr/local/go; \
tar -C /usr/local -xzf $1;
then
    export PATH=$PATH:/usr/local/go/bin
    go version
    echo "GO instalado.."
else
    echo "Erro ao instalar GO.."
    exit 1
fi

echo
echo "------"
echo

echo "Instalando DBeaver.."

if dnf install java-11-openjdk-devel \
&& yum -y install wget \
rpm -Uvh ./dbeaver-ce-latest-stable.x86_64.rpm;
then
    echo "DBeaver instalado.."
else
    echo "Erro ao instalar DBeaver.."
    exit 1
fi

echo
echo "------"
echo

echo "Instalando Docker.."

if dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine; \
dnf -y install dnf-plugins-core \
&& dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo \
&& dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin \
&& systemctl start docker;
then
    echo "Docker instalado.."
else
    echo "Erro ao instalar Docker.."
    exit 1
fi

echo
echo "------"
echo

echo "Instalando Postgre no docker.."

if docker run --name postgres -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres;
then
    echo "Postgre instalado no docker.."
else
    echo "Erro ao instalar postgre no docker.."
fi

echo
echo "------"
echo

echo "Instalando Imsomnia.."

if snap install insomnia;
then
    echo "Imsomnia instalado.."
else
    echo "Erro ao instalar insomnia.."
fi

echo
echo "------"
echo

exit 0