#!/bin/sh

# Copyright (c) 2024
#
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without
# fee is hereby granted, provided that the above copyright notice and this permission notice appear
# in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE
# INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE
# FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
# ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
# Author: Zheng Qian <sotux82@gmail.com>

# This script is used to update the GeoIP database for the luci-app-dae package.
# It will download the latest GeoIP database from Loyalsoldier or v2fly.
# If user choose to use the database from Loyalsoldier, the database will be downloaded from below URLs:
# https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geoip.dat
# https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geosite.dat
# If user choose to use the database from v2fly, the database will be downloaded from below URLs:
# https://github.com/v2fly/geoip/releases/latest/download/geoip.dat
# https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat

# Get which database to download from the config file
GeoDB=$(uci get dae.config.geodb)

if [ "$GeoDB" = "loyalsoldier" ]; then
    # Download the GeoIP database from Loyalsoldier and check the result
    wget -q --show-progress -O /tmp/geoip.dat https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geoip.dat
    if [ $? -ne 0 ]; then
        echo "Failed to download the GeoIP database from Loyalsoldier"
        exit 1
    fi
    wget -q --show-progress -O /tmp/geosite.dat https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geosite.dat
    if [ $? -ne 0 ]; then
        echo "Failed to download the GeoSite database from Loyalsoldier"
        exit 1
    fi
elif [ "$GeoDB" = "v2fly" ]; then
    # Download the GeoIP database from v2fly and check the result
    wget -q --show-progress -O /tmp/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat
    if [ $? -ne 0 ]; then
        echo "Failed to download the GeoIP database from v2fly"
        exit 1
    fi
    wget -q --show-progress -O /tmp/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat
    if [ $? -ne 0 ]; then
        echo "Failed to download the Domain List Community database from v2fly"
        exit 1
    fi
else
    echo "Invalid GeoDB value in the config file"
    exit 1
fi

# Move the downloaded database to the correct location.
# if geoip.dat and geosite.dat are symlinks, move the
# new database to the target of the symlink.
if [ -L /usr/share/dae/geoip.dat ]; then
    mv /tmp/geoip.dat $(readlink -f /usr/share/dae/geoip.dat)
else
    mv /tmp/geoip.dat /usr/share/dae/geoip.dat
fi
if [ -L /usr/share/dae/geosite.dat ]; then
    mv /tmp/geosite.dat $(readlink -f /usr/share/dae/geosite.dat)
else
    mv /tmp/geosite.dat /usr/share/dae/geosite.dat
fi

# Restart dae service to apply the new database
/etc/init.d/dae restart
