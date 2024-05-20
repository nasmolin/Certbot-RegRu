#!/bin/bash

# Copyright (C) 2019 Martijn Veldpaus
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details

SCRIPTDIR=$(dirname $(readlink -f $0))
source $SCRIPTDIR/api-settings.sh

certbot certonly \
        --non-interactive \
        --agree-tos \
        --manual-public-ip-logging-ok \
        -m "$EMAIL" \
        --preferred-challenges dns \
        --manual \
        --manual-auth-hook $SCRIPTDIR/regru-create-record.sh \
        --manual-cleanup-hook $SCRIPTDIR/regru-cleanup-record.sh \
        -d *.$SUBDOMAIN.$DOMAIN