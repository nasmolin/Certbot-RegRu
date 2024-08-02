#!/bin/bash

# Copyright (C) 2019 
# All rights reserved. Martijn Veldpaus
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details

source $(dirname $(readlink -f $0))/api-settings.sh
temp_domain="example.com"
DNS_REC_TYPE=TXT
DNS_REC_NAME=$TXT_SUBDOMAIN
DNS_REC_DATA=$CERTBOT_VALIDATION
REGRU_API_URL="https://api.reg.ru/api/regru2"
API_METHOD="/zone/add_txt"
INPUT_DATA='{"username":"'$USERNAME'","password":"'$PASSWORD'","domains":[{"dname":"'$DOMAIN'"}],"subdomain":"'$DNS_REC_NAME'","text":"'$DNS_REC_DATA'","output_content_type":"plain"}'
BASE_URL=$REGRU_API_URL$API_METHOD"?input_data="$INPUT_DATA"&input_format=json"


echo "[INFO] Creating "${DNS_REC_TYPE}" record "${DNS_REC_NAME}" for certificate renewal with value "${DNS_REC_DATA}

curl --location \
     --globoff \
     --request POST $BASE_URL
     
#30m
max_attempts=120
delay=15

attempt_counter=0
check=$(dig -t txt @8.8.8.8 _$DNS_REC_NAME.$temp_domain +short | grep -q $DNS_REC_DATA; echo $?)

echo "[INFO] DNS-TXT record was created on Reg.ru."
echo "[INFO] Waiting for the txt record to become available on Google’s DNS servers"
echo "[DEBUG] Parameters: max_attempts="${max_attempts}", delay="${delay}"s"

until [ $check -eq "0" ];do
    if [ ${attempt_counter} -eq ${max_attempts} ];then
      echo "[FATAL] Max attempts reached"
      exit 1
    fi

    printf "[INFO] The TXT-record is not yet available. Wait "${delay}"s before re-checking..."
    attempt_counter=$(($attempt_counter+1))
    sleep $delay
done

wasted_time=$($attempt_counter*$delay)
echo "[DONE] TXT-record found after ~"$wasted_time"s."
exit 0
