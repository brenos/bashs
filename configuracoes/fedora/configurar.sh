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
    echo "-----------" >> $log
    echo "Apps" >> $log
    echo "-----------" >> $log

    echo "Instalando wget, curl e gpg.." >> $log

    if dnf install wget curl gpg;
    then
        echo "Wget, curl e gpg instalados.." >> $log
    else
        echo "Erro ao instalar wget, curl e gpg.." >> $log
        exit 1
    fi

    echo >> $log
    echo "------" >> $log
    echo >> $log

    echo "Instalando zsh.." >> $log

    if dnf install zsh \
    && usermod -s "$(which zsh)" $USER;
    then
        echo "Zsh instalado.." >> $log
    else
        echo "Erro ao instalar zsh.." >> $log
    fi

    echo >> $log
    echo "------" >> $log
    echo >> $log

    echo "Instalando Discord.." >> $log

    if dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    && dnf update \
    && dnf install discord;
    then
        echo "Discord instalado.." >> $log
    else
        echo "Erro ao instalar Discord.." >> $log
    fi

    echo >> $log
    echo "------" >> $log
    echo >> $log

    echo "Instalando Brave.." >> $log

    if dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/ \
    && rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc \
    && dnf install brave-browser -y;
    then
        echo "Bravo instalado.." >> $log
    else
        echo "Erro ao instalar Brave.." >> $log
    fi
fi

echo "-----------------------------" >> $log

echo "Instalar ambiente dev? [s,N]"
read input

if [[ $input == "s" ]];
then
    echo "-----------" >> $log
    echo "Apps Dev" >> $log
    echo "-----------" >> $log

    echo "Instalando VS Code.." >> $log

    if rpm --import https://packages.microsoft.com/keys/microsoft.asc \
    && sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' \
    && dnf check-update \
    && dnf install code;
    then
        echo "VS Code instalado.." >> $log
    else
        echo "Erro ao instalar VS Code.." >> $log
        exit 1
    fi

    echo >> $log
    echo "------" >> $log
    echo >> $log

    echo "Path do arquivo GO baixado? (Deixar em branco para NAO instalar)"
    read pathGo

    if [[ $pathGo != "" ]];
    then
        echo "Instalando GO.." >> $log
        if [ -d "/usr/local/go" ]
        then
            rm -rf /usr/local/go
        fi

        if  tar -C /usr/local -xzf $pathGo;
        then
            export PATH=$PATH:/usr/local/go/bin
            go version
            echo "GO instalado.." >> $log
        else
            echo "Erro ao instalar GO.." >> $log
            exit 1
        fi

        echo >> $log
        echo "------" >> $log
        echo >> $log
    fi


    echo "Instalar DBeaver? [s,N]"
    read inputDbEaver

    if [[ $inputDbEaver == "s" ]];
    then
        echo "Instalando DBeaver.." >> $log

        if dnf install java-latest-openjdk-devel.x86_64 \
        && wget https://dbeaver.io/files/dbeaver-ce-latest-stable.x86_64.rpm \
        && rpm -Uvh ./dbeaver-ce-latest-stable.x86_64.rpm;
        then
            echo "DBeaver instalado.." >> $log
        else
            echo "Erro ao instalar DBeaver.." >> $log
            exit 1
        fi

        echo >> $log
        echo "------" >> $log
        echo >> $log
    fi

    echo "Instalar Docker? [s,N]"
    read inputDocker

    if [[ $inputDocker == "s" ]];
    then

        echo "Instalando Docker.." >> $log

        if dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine; \
        dnf -y install dnf-plugins-core \
        && dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo \
        && dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin \
        && systemctl start docker;
        then
            echo "Docker instalado.." >> $log
        else
            echo "Erro ao instalar Docker.." >> $log
            exit 1
        fi

        echo >> $log
        echo "------" >> $log
        echo >> $log

        echo "Instalando Postgre no docker.." >> $log

        if docker run --name postgres -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres;
        then
            echo "Postgre instalado no docker.." >> $log
        else
            echo "Erro ao instalar postgre no docker.." >> $log
        fi

        echo >> $log
        echo "------" >> $log
        echo >> $log

        echo "Instalando MySQL no docker.." >> $log
        echo "---------------------" >> $log
        echo >> $log

        if docker run --name mysql -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=12345678 mysql;
        then
            echo
            echo "Postgre instalado no docker.." >> $log
        else
            echo "Erro ao instalar postgre no docker.." >> $log
        fi
    fi

    echo >> $log
    echo "------" >> $log
    echo >> $log

    echo "Instalar MySQL Workbench? [s,N]"
    read inputMSQLWb

    if [[ $inputMSQLWb == "s" ]];
    then
        echo "Instalando MySQL Workbench.." >> $log
        echo "---------------------" >> $log
        echo >> $log

        if rpm -Uvh mysql80-community-release-* \
        && yum install mysql-workbench;
        then
            echo
            echo "MySQLWorkbench instalado.." >> $log
        else
            echo "Erro ao instalar MySQLWorkbench.." >> $log
        fi

        echo >> $log
        echo "------" >> $log
        echo >> $log
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