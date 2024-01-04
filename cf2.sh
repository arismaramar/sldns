#!/bin/bash
# // font color configuration

MYIP=$(curl -sS ipv4.icanhazip.com)
LAST_DOMAIN="$(cat /etc/xray/domain)"
NS="$(cat /etc/xray/dns)"
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
clear

function get_acme_domain() {
    anggunre=$(cat /etc/xray/domain)
    clear
    echo -e " ┌─────────────────────────────────────────────────────────┐"
    echo -e "─│                        ${CYAN}WELCOME TO${NC}                       │─"
    echo -e "─│    ${ORANGE}┌─┐┬ ┬┌┬┐┌─┐┌─┐┌─┐┬─┐┬┌─┐┌┬┐  ┌─┐┬─┐┌─┐┌┬┐┬┬ ┬┌┬┐${NC}    │─"
    echo -e "─│    ${ORANGE}├─┤│ │ │ │ │└─┐│  ├┬┘│├─┘ │   ├─┘├┬┘├┤ │││││ ││││${NC}    │─"
    echo -e "─│    ${ORANGE}┴ ┴└─┘ ┴ └─┘└─┘└─┘┴└─┴┴   ┴   ┴  ┴└─└─┘┴ ┴┴└─┘┴ ┴${NC}    │─"
    echo -e "─│        ${RED}POWERRED ANGGUN${NC} | ${GREEN}TELEGRAM: @amantubilah${NC}       │─"
    echo -e " └─────────────────────────────────────────────────────────┘"
    echo -e "─────────────────────────────────────────────────────────────"
    echo -e "               ${GREEN}PROSES GANTI DOMAIN & NS-DOMAIN${NC}"
    echo -e "─────────────────────────────────────────────────────────────"
    echo -e "   [${ORANGE}INFO${NC}] ${CYAN}Proses sedang berlangsung${NC} "
    systemctl stop nginx
    systemctl stop haproxy
	systemctl stop xray
    sleep 2
    echo -e "   [${ORANGE}INFO${NC}] ${CYAN}Memperbarui semua sertifikat${NC}"
    sleep 2
    echo -e "   [${ORANGE}INFO${NC}] ${CYAN}Sedang mendownload sertifikat kedalam VPS${NC}"
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade >/dev/null 2>&1
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt >/dev/null 2>&1
    /root/.acme.sh/acme.sh --issue -d $anggunre --standalone -k ec-256 >/dev/null 2>&1
    ~/.acme.sh/acme.sh --installcert -d $anggunre --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc >/dev/null 2>&1
    rm /etc/haproxy/yha.pem >/dev/null 2>&1
    cat /etc/xray/xray.crt /etc/xray/xray.key | tee >/dev/null 2>&1
    echo -e "   [${GREEN}DONE${NC}] ${CYAN}Pembaruan Sertifikat Selesai${NC}"
    sed -i "s/${LAST_DOMAIN}/${anggunre}/g" /etc/nginx/conf.d/xray.conf >/dev/null 2>&1
    sed -i "s/${LAST_DOMAIN}/${anggunre}/g" /var/www/html/index.html >/dev/null 2>&1
    sed -i "s/${LAST_DOMAIN}/${anggunre}/g" /etc/haproxy/haproxy.cfg >/dev/null 2>&1
    sed -i "s/${LAST_DOMAIN}/${anggunre}/g" /etc/haproxy/haproxy.cfg >/dev/null 2>&1
    sed -i "s/${LAST_DOMAIN}/${anggunre}/g" /etc/openvpn/tcp.ovpn >/dev/null 2>&1
    sed -i "s/${LAST_DOMAIN}/${anggunre}/g" /etc/openvpn/udp.ovpn >/dev/null 2>&1
    sed -i "s/${LAST_DOMAIN}/${anggunre}/g" /etc/openvpn/ssl.ovpn >/dev/null 2>&1
    sed -i "s/${LAST_DOMAIN}/${anggunre}/g" /etc/openvpn/ws-ssl.ovpn >/dev/null 2>&1
    sed -i "s/${LAST_DOMAIN}/${anggunre}/g" /var/www/html/index.html >/dev/null 2>&1
    sleep 2
    echo -e "   [${ORANGE}INFO${NC}] ${CYAN}Restart Daemon Reload Service${NC}"
    systemctl daemon-reload >/dev/null 2>&1
    sleep 2
    echo -e "   [${ORANGE}INFO${NC}] ${CYAN}Restart SlowDns Server Service${NC}"
    systemctl restart server >/dev/null 2>&1
    sleep 2
    echo -e "   [${ORANGE}INFO${NC}] ${CYAN}Restart SlowDns Client Service${NC}"
    systemctl restart client >/dev/null 2>&1
    sleep 2
    echo -e "   [${ORANGE}INFO${NC}] ${CYAN}Restart Haproxy Loadbalance${NC}"
    systemctl restart haproxy >/dev/null 2>&1
    sleep 2
    echo -e "   [${ORANGE}INFO${NC}] ${CYAN}Restart Nginx WebServer${NC}"
    systemctl restart nginx >/dev/null 2>&1
    sleep 2
    echo -e "   [${ORANGE}INFO${NC}] ${CYAN}Restart Xray Service${NC}"
    systemctl restart xray >/dev/null 2>&1
    sleep 2
    echo -e "   [${GREEN}DONE${NC}] ${CYAN}Ganti Domain dan Restart Service Selesai"
    sleep 2
    echo -e "   [${ORANGE}INFO${NC}] ${CYAN}Proses pointing NS-Domain${NC} "
    sleep 3
}
ns_domain_cloudflare() {
    wget https://raw.githubusercontent.com/arismaramar/sldns/main/cfnanggunre.sh>/dev/null 2>&1 && chmod +x cfnanggunre.sh && ./cfnanggunre.sh >/dev/null 2>&1
    NSVPSKU=$(cat /etc/xray/dns)
    sleep 3
    sed -i "s/$NS/$NSVPSKU/g" /etc/systemd/system/client.service >/dev/null 2>&1
    sed -i "s/$NS/$NSVPSKU/g" /etc/systemd/system/server.service >/dev/null 2>&1
    echo -e "   [${ORANGE}DONE${NC}] ${CYAN}Domain kamu sekarang${NC} [${ORANGE}$anggunre${NC}]"
    sleep 2
    echo -e "   [${ORANGE}DONE${NC}] ${CYAN}NS-Domain kamu sekarang${NC} [${ORANGE}$NSVPSKU${NC}]"
    sleep 2
    echo -e "─────────────────────────────────────────────────────────────"
    read -n 2 -s -r -p "Tekan sembarang untuk kembali ke menu"
    menu
}

cloudflare() {
    echo -e "   [${ORANGE}INFO${NC}] ${CYAN}Proses Pointing Sedang Berlangsung${NC} "
    wget https://raw.githubusercontent.com/arismaramar/sldns/main/cfdanggunre.sh  >/dev/null 2>&1 && chmod +x cfdanggunre.sh && ./cfdanggunre.sh >/dev/null 2>&1
    get_acme_domain
    ns_domain_cloudflare
}

clear

