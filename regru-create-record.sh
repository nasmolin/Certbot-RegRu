#!/bin/bash

# Copyright (C) 2019 
# All rights reserved. Martijn Veldpaus
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details

source $(dirname $(readlink -f $0))/api-settings.sh
DNS_REC_TYPE=TXT
DNS_REC_NAME=$TXT_SUBDOMAIN
DNS_REC_DATA=$CERTBOT_VALIDATION
REGRU_API_URL="https://api.reg.ru/api/regru2"
API_METHOD="/zone/add_txt"
INPUT_DATA='{"username":"'$USERNAME'","password":"'$PASSWORD'","domains":[{"dname":"'$DOMAIN'"}],"subdomain":"'$DNS_REC_NAME'","text":"'$DNS_REC_DATA'","output_content_type":"plain"}'
BASE_URL=$REGRU_API_URL$API_METHOD"?input_data="$INPUT_DATA"&input_format=json"


echo Creating ${DNS_REC_TYPE} record ${DNS_REC_NAME} for certificate renewal with value ${DNS_REC_DATA}

curl --location \
     --globoff \
     --request POST $BASE_URL

sleep 300s