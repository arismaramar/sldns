#!/bin/bash
DOMAIN=vpnpro.tech
sub=$(tr </dev/urandom -dc a-z0-9 | head -c4)
SUB_DOMAIN=${sub}.vpnpro.tech
CF_ID=arismar.amar@gmail.com
CF_KEY=88ecae78b53455a919ccecd22bdbd0332f7c7
set -euo pipefail
IP=$(wget -qO- ipinfo.io/ip)
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","proxied":false}')
echo $SUB_DOMAIN >/etc/xray/domain
echo "Subdomain kamu adalah : $SUB_DOMAIN"
sleep 3
rm -f /root/cfdvpnpro.sh

systemctl stop nginx
systemctl stop xray
systemctl stop haproxy
    wget https://raw.githubusercontent.com/arismaramar/sldns/main/cfnvpnpro.sh >/dev/null 2>&1 && chmod +x cfnvpnpro.sh && ./cfnvpnpro.sh >/dev/null 2>&1
    NSVPSKU=$(cat /etc/xray/dns)
    sleep 3
    sed -i "s/$NS/$NSVPSKU/g" /etc/systemd/system/client.service >/dev/null 2>&1
    sed -i "s/$NS/$NSVPSKU/g" /etc/systemd/system/server.service >/dev/null 2>&1
    echo -e "   [${ORANGE}DONE${NC}] ${CYAN}Domain kamu sekarang${NC} [${ORANGE}$baru${NC}]"
    sleep 2
    echo -e "   [${ORANGE}DONE${NC}] ${CYAN}NS-Domain kamu sekarang${NC} [${ORANGE}$NSVPSKU${NC}]"
    sleep 1
	rm -f /root/cfnvpnpro.sh
