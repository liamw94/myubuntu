#!/bin/bash

RED='\033[0;31m';
NC='\033[0m'; # No Color
GREEN='\033[0;32m';
YELLOW='\033[1;33m';

CWD=`pwd`;

delay_after_message=3;

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run with sudo (sudo -i)" 
   exit 1
fi

apt update -y;


#Install Z Shell
printf "${YELLOW}Installing ZSH (Shell)${NC}\n";
sleep $delay_after_message;
apt install zsh -y
sleep 2;
chsh -s /bin/zsh

git clone git@github.com:liamw94/zsh.git ~
~/zsh/install.sh

# Some basic shell utlities
printf "${YELLOW}Installing git, curl and nfs-common.. ${NC}\n";
sleep $delay_after_message;
apt install git -y
apt install curl -y
apt install nfs-common -y
apt install preload -y

#Install Node Version Manager
printf "${YELLOW}Installing Node Version Manager${NC}\n";
sleep $delay_after_message;
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | zsh

printf "${YELLOW}Installing Latest LTS Version of NodeJS${NC}\n";
sleep $delay_after_message;
source ~/.zshrc && nvm install --lts

#Install VIM
printf "${YELLOW}Installing VIM${NC}\n";
sleep $delay_after_message;
apt install vim -y

#Docker
printf "${YELLOW}Installing Docker ${NC}\n";
sleep $delay_after_message;
apt install docker.io -y
systemctl enable --now docker
usermod -aG docker $target_user;

#Install Open-SSH Server
printf "${YELLOW}Installing OpenSSH Server ${NC}\n";
sleep $delay_after_message;
apt install openssh-server -y
systemctl enable ssh
systemctl start ssh

#Install Chromium
printf "${YELLOW}Installing chromium-browser${NC}\n";
sleep $delay_after_message;
apt install chromium-browser -y

apt dist-upgrade -y;
chsh -s /bin/zsh