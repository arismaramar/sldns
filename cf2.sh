#!/bin/bash
# // font color configuration
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
Font="\033[0m"
gray="\e[1;30m"
total_ram=$(grep "MemTotal: " /proc/meminfo | awk '{ print $2}')
totalram=$(($total_ram / 1024))
MYIP=$(curl -sS ipv4.icanhazip.com)
SUB_DOMAIN="$(cat /etc/xray/domain)"
NS="$(cat /etc/xray/dns)"
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
clear
echo -e "   [${ORANGE}INFO${NC}] ${CYAN}ponting ke domain anggunre.shop berlangsung${NC} "
wget -O cfdanggunre.sh https://raw.githubusercontent.com/arismaramar/sldns/main/cfdanggunre.sh >/dev/null 2>&1 && chmod +x cfdanggunre.sh && ./cfdanggunre.sh >/dev/null 2>&1
 sleep 3
wget -O cfnanggunre.sh  https://raw.githubusercontent.com/arismaramar/sldns/main/cfnanggunre.sh >/dev/null 2>&1 && chmod +x cfnanggunre.sh && ./cfnanggunre.sh >/dev/null 2>&1
sleep 3

echo "Subdomain kamu adalah : $SUB_DOMAIN"
echo "NS_DOMAIN kamu adalah : $NS"
