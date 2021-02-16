#
# Copyright (C) 2017
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI Support for shadowsocks
LUCI_DEPENDS:=+ipset +iptables-mod-tproxy +shadowsocks-libev-alt +curl
LUCI_PKGARCH:=all

PKG_LICENSE:=Apache-2.0

include ../../luci.mk

# call BuildPackage - OpenWrt buildroot signature
