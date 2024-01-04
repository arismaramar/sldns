#!/bin/bash
DOMAIN=anggunre.shop
sub=$(tr </dev/urandom -dc a-z0-9 | head -c4)
SUB_DOMAIN=${sub}.anggunre.shop
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
rm -f /root/cfanggunre.sh

#!/bin/bash
DOMAIN="anggunre.shop"
DAOMIN=$(cat /etc/xray/domain)
SUB=$(tr </dev/urandom -dc a-z0-9 | head -c4)
SUB_DOMAIN=${SUB}."anggunre.shop"
NS_DOMAIN=ns.${SUB_DOMAIN}
CF_ID=arismar.amar@gmail.com
CF_KEY=88ecae78b53455a919ccecd22bdbd0332f7c7
set -euo pipefail
IP=$(wget -qO- ipinfo.io/ip)
echo "Updating DNS NS for ${NS_DOMAIN}..."
ZONE=$(
	curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
	-H "X-Auth-Email: ${CF_ID}" \
	-H "X-Auth-Key: ${CF_KEY}" \
	-H "Content-Type: application/json" | jq -r .result[0].id
)

RECORD=$(
	curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${NS_DOMAIN}" \
	-H "X-Auth-Email: ${CF_ID}" \
	-H "X-Auth-Key: ${CF_KEY}" \
	-H "Content-Type: application/json" | jq -r .result[0].id
)

if [[ "${#RECORD}" -le 10 ]]; then
	RECORD=$(
		curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
		-H "X-Auth-Email: ${CF_ID}" \
		-H "X-Auth-Key: ${CF_KEY}" \
		-H "Content-Type: application/json" \
		--data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${DAOMIN}'","proxied":false}' | jq -r .result.id
	)
fi

RESULT=$(
	curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
	-H "X-Auth-Email: ${CF_ID}" \
	-H "X-Auth-Key: ${CF_KEY}" \
	-H "Content-Type: application/json" \
	--data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${DAOMIN}'","proxied":false}'
)
echo $NS_DOMAIN >/etc/xray/dns
echo "dns kamu adalah : $NS_DOMAIN"
rm -f /root/cfnanggunre.sh
