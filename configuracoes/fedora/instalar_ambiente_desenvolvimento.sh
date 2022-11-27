#!/bin/bash

echo "-----------" >> $1
echo "Apps Dev" >> $1
echo "-----------" >> $1

echo "Instalando VS Code.." >> $1

if rpm --import https://packages.microsoft.com/keys/microsoft.asc \
&& sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' \
&& dnf check-update \
&& dnf install code;
then
    echo "VS Code instalado.." >> $1
else
    echo "Erro ao instalar VS Code.." >> $1
    exit 1
fi

echo >> $1
echo "------" >> $1
echo >> $1

echo "Instalando GO.." >> $1

if rm -rf /usr/local/go; \
tar -C /usr/local -xzf $2;
then
    export PATH=$PATH:/usr/local/go/bin
    go version
    echo "GO instalado.." >> $1
else
    echo "Erro ao instalar GO.." >> $1
    exit 1
fi

echo >> $1
echo "------" >> $1
echo >> $1

echo "Instalando DBeaver.." >> $1

if dnf install java-11-openjdk-devel \
&& yum -y install wget \
rpm -Uvh ./dbeaver-ce-latest-stable.x86_64.rpm;
then
    echo "DBeaver instalado.." >> $1
else
    echo "Erro ao instalar DBeaver.." >> $1
    exit 1
fi

echo >> $1
echo "------" >> $1
echo >> $1

echo "Instalando Docker.." >> $1

if dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine; \
dnf -y install dnf-plugins-core \
&& dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo \
&& dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin \
&& systemctl start docker;
then
    echo "Docker instalado.." >> $1
else
    echo "Erro ao instalar Docker.." >> $1
    exit 1
fi

echo >> $1
echo "------" >> $1
echo >> $1

echo "Instalando Postgre no docker.." >> $1

if docker run --name postgres -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres;
then
    echo "Postgre instalado no docker.." >> $1
else
    echo "Erro ao instalar postgre no docker.." >> $1
fi

echo >> $1
echo "------" >> $1
echo >> $1

echo "Instalando MySQL no docker.." >> $1
echo "---------------------" >> $1
echo >> $1

if docker run --name mysql -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=12345678 mysql;
then
    echo
    echo "Postgre instalado no docker.." >> $1
else
    echo "Erro ao instalar postgre no docker.." >> $1
fi

echo >> $1
echo "------" >> $1
echo >> $1

echo "Instalando MySQL Workbench.." >> $1
echo "---------------------" >> $1
echo >> $1

if rpm -Uvh mysql80-community-release-* \
&& yum install mysql-workbench;
then
    echo
    echo "MySQLWorkbench instalado.." >> $1
else
    echo "Erro ao instalar MySQLWorkbench.." >> $1
fi

echo >> $1
echo "------" >> $1
echo >> $1

echo "Instalando Imsomnia.." >> $1

if snap install insomnia;
then
    echo "Imsomnia instalado.." >> $1
else
    echo "Erro ao instalar insomnia.." >> $1
fi

echo >> $1
echo "------" >> $1
echo >> $1
