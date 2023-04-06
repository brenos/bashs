#!/bin/bash

log=log_file.txt
 
# create log file or overrite if already present
printf "Log File - " > $log
 
# append date to log file
date >> $log

echo "Atualizando repositórios.." >> $log

if dnf update; 
then
    echo "Repositórios atualizados.." >> $log
else
    echo "Não foi possivel atualizar os repositórios.." >> $log
    exit 1
fi

echo "Upgradeando repositórios.." >> $log

if dnf upgrade;
then
    echo "Repositórios upgradeadas.." >> $log
else
    echo "Não foi possível upgradear os repositórios.." >> $log
    exit 1
fi

echo "-----------------------------" >> $log

echo "Instalar apps? [s,N]"
read inputApps

if [[ $inputApps == "s" ]];
then
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
fi

echo "-----------------------------" >> $log

echo "Instalar ambiente dev? [s,N]"
read input

if [[ $input == "s" ]];
then
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

    echo "Path do arquivo GO baixado? (Deixar em branco para NAO instalar)"
    read pathGo

    if [[ $pathGo != "" ]];
    then
        echo "Instalando GO.." >> $1
        if [ -d "/usr/local/go" ]
        then
            rm -rf /usr/local/go;
        fi

        if  tar -C /usr/local -xzf $pathGo;
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
    fi


    echo "Instalar DBeaver? [s,N]"
    read inputDbEaver

    if [[ $inputDbEaver == "s" ]];
    then
        echo "Instalando DBeaver.." >> $1

        if dnf java-17-openjdk-devel \
        && yum -y install wget \
        && rpm -Uvh ./dbeaver-ce-latest-stable.x86_64.rpm;
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

    echo "Instalar MySQL Workbench? [s,N]"
    read inputMSQLWb

    if [[ $inputMSQLWb == "s" ]];
    then
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
    fi
fi

echo >> $log
echo >> $log
echo "Nao esqueca de ver o site https://docs.fedoraproject.org/en-US/quick-docs/configuring-xorg-as-default-gnome-session/" >> $log
echo >> $log

echo "Instalando Oh my zsh.."

if sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
then
    echo "Oh my zsh instalado.."
else
    echo "Erro ao instalar oh my zsh.."
fi

echo
echo "------"
echo

exit 0