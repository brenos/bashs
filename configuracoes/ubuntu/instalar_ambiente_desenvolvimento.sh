#!/bin/bash

echo "-----------" >> $1
echo "Apps Dev" >> $1
echo "-----------" >> $1

echo >> $1
echo "Instalando git.." >> $1
echo "---------------------" >> $1
echo  >> $1

if apt install git;
then
    git config --global user.name "brenos"
    git config --global user.email "soubreno@gmail.com"
    echo
    echo "Git instalado.." >> $1
else
    echo "Erro ao instalar git.." >> $1
fi

echo >> $1
echo "------" >> $1
echo >> $1

echo "Instalando VS Code.." >> $1
echo "---------------------" >> $1
echo >> $1

if wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
&& install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \
&& sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' \
&& rm -f packages.microsoft.gpg \
&& apt install apt-transport-https \
&& apt update \
&& apt install code;
then
    echo
    echo "VS Code instalado.." >> $1
else
    echo "Erro ao instalar VS Code.." >> $1
fi

echo >> $1
echo "------" >> $1
echo >> $1

echo "Path + arquivo zip GO baixado? (Deixar em branco para NAO instalar)"
read pathGo

if [[ $pathGo != "" ]];
then
    echo "Instalando GO.." >> $1
    echo "---------------------" >> $1
    echo >> $1

    if rm -rf /usr/local/go; \
    tar -C /usr/local -xzf $pathGo;
    then
        export PATH=$PATH:/usr/local/go/bin
        echo
        echo "GO instalado.." >> $1
    else
        echo "Erro ao instalar GO.." >> $1
    fi

    echo >> $1
    echo "------" >> $1
    echo >> $1
fi

echo "Path + arquivo zip DBeaver baixado? (Deixar em branco para NAO instalar)"
read pathDbeaver

if [[ $pathDbeaver != "" ]];
then
    echo "Instalando DBeaver.." >> $1
    echo "---------------------" >> $1
    echo >> $1

    if ./$pathDbeaver;
    then
        echo "DBeaver instalado.." >> $1
    else
        echo "Erro ao instalar DBeaver.." >> $1
        exit 1
    fi

    echo >> $1
    echo "------" >> $1
    echo >> $1
fi


echo "Instalando Docker.." >> $1
echo "---------------------" >> $1
echo >> $1

if apt-get remove docker docker-engine docker.io containerd runc; \
apt-get install ca-certificates gnupg lsb-release \
&& mkdir -p /etc/apt/keyrings \
&& curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
&& apt-get update \
&& apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin;
then
    echo
    echo "Docker instalado.." >> $1
else
    echo "Erro ao instalar Docker.." >> $1
fi

echo >> $1
echo "------" >> $1
echo >> $1

echo "Instalando Postgre no docker.." >> $1
echo "---------------------" >> $1
echo >> $1

if docker run --name postgres -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres;
then
    echo
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

echo "Instalar MySQL Workbench? (s,N)"
read installMySQLWb

if [[ $installMySQLWb == "s" ]];
then
    echo "Instalando MySQL Workbench.." >> $1
    echo "---------------------" >> $1
    echo >> $1

    if apt install mysql-workbench;
    then
        echo
        echo "MySQLWorkbench instalado.." >> $1
    else
        echo "Erro ao instalar MySQLWorkbench.." >> $1
    fi

    echo >> $1
    echo "------" >> $1
    echo >> $1
fi

echo "Instalando Imsomnia.." >> $1
echo "---------------------" >> $1
echo >> $1

if echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" | tee -a /etc/apt/sources.list.d/insomnia.list \
&& apt-get update \
&& apt-get install insomnia;
then
    echo
    echo "Imsomnia instalado.." >> $1
else
    echo "Erro ao instalar insomnia.." >> $1
fi
