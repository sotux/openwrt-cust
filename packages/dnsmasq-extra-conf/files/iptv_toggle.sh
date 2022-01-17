#!/bin/sh

case "$1" in
up)
    ubus call network.interface.vlan51 up
    ubus call network.interface.vlan85 up
    ;;
down)
    ubus call network.interface.vlan51 down
    ubus call network.interface.vlan85 down
    ;;
*)
    echo "Usage: iptv_toggle {up|down}"
    exit 1
    ;;
esac

exit 0
