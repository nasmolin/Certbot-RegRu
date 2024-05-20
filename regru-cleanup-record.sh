#!/bin/bash
# certbot-cleanup-record.sh -- A Certbot cleanup callback script
#
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
API_METHOD="/zone/remove_record"
INPUT_DATA='{"username":"'$USERNAME'","password":"'$PASSWORD'","domains":[{"dname":"'$DOMAIN'"}],"subdomain":"'$DNS_REC_NAME'","content":"'$DNS_REC_DATA'","record_type":"'$DNS_REC_TYPE'","output_content_type":"plain"}'
BASE_URL=$REGRU_API_URL$API_METHOD"?input_data="$INPUT_DATA"&input_format=json"


echo Delete ${DNS_REC_TYPE} record ${DNS_REC_NAME}

curl --location \
     --globoff \
     --request POST $BASE_URL