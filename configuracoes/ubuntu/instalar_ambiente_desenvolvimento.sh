#!/bin/bash

echo "-----------"
echo "Apps Dev"
echo "-----------"

echo
echo "Instalando git.."
echo "---------------------"
echo

if apt install git;
then
    git config --global user.name "brenos"
    git config --global user.email "soubreno@gmail.com"
    echo
    echo "Git instalado.."
else
    echo "Erro ao instalar git.."
    exit 1
fi

echo
echo "------"
echo

echo "Instalando VS Code.."
echo "---------------------"
echo

if wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
&& install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \
&& sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' \
&& rm -f packages.microsoft.gpg \
&& apt install apt-transport-https \
&& apt update \
&& apt install code;
then
    echo
    echo "VS Code instalado.."
else
    echo "Erro ao instalar VS Code.."
    exit 1
fi

echo
echo "------"
echo

echo "Instalando GO.."
echo "---------------------"
echo

if rm -rf /usr/local/go; \
tar -C /usr/local -xzf $1;
then
    export PATH=$PATH:/usr/local/go/bin
    echo
    echo "GO instalado.."
else
    echo "Erro ao instalar GO.."
    exit 1
fi

echo
echo "------"
echo

echo "Instalando DBeaver.."

if [[ $2 != "" ]];
then
    if ./$2;
    then
        echo "DBeaver instalado.."
    else
        echo "Erro ao instalar DBeaver.."
        exit 1
    fi
fi

echo
echo "------"
echo

echo "Instalando Docker.."
echo "---------------------"
echo

if apt-get remove docker docker-engine docker.io containerd runc; \
apt-get install ca-certificates gnupg lsb-release \
&& mkdir -p /etc/apt/keyrings \
&& curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
&& apt-get update \
&& apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin;
then
    echo
    echo "Docker instalado.."
else
    echo "Erro ao instalar Docker.."
    exit 1
fi

echo
echo "------"
echo

echo "Instalando Postgre no docker.."
echo "---------------------"
echo

if docker run --name postgres -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres;
then
    echo
    echo "Postgre instalado no docker.."
else
    echo "Erro ao instalar postgre no docker.."
fi

echo
echo "------"
echo

echo "Instalando MySQL no docker.."
echo "---------------------"
echo

if docker run --name mysql -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=12345678 mysql;
then
    echo
    echo "Postgre instalado no docker.."
else
    echo "Erro ao instalar postgre no docker.."
fi

echo
echo "------"
echo

echo "Instalando Imsomnia.."
echo "---------------------"
echo

if echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" | tee -a /etc/apt/sources.list.d/insomnia.list \
&& apt-get update \
&& apt-get install insomnia;
then
    echo
    echo "Imsomnia instalado.."
else
    echo "Erro ao instalar insomnia.."
fi
