#!/bin/bash
cf() {
    echo -e "   [${ORANGE}INFO${NC}] ${CYAN}ponting ke vpnpro.tech berlangsung${NC} "
    wget https://raw.githubusercontent.com/arismaramar/sldns/main/cfdvpnpro.sh >/dev/null 2>&1 && chmod +x cfdvpnpro.sh && ./cfdvpnpro.sh >/dev/null 2>&1
    ns_domain_cloudflare
   
}

ns_domain_cloudflare() {
    wget https://raw.githubusercontent.com/arismaramar/sldns/main/cfnvpnpro.sh >/dev/null 2>&1 && chmod +x cfnvpnpro.sh && ./cfnvpnpro.sh >/dev/null 2>&1


echo "Subdomain kamu adalah : $SUB_DOMAIN"
echo "NS_DOMAIN kamu adalah : $NS_DOMAIN"
