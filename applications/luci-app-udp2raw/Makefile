#
# Copyright (C) 2017
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-udp2raw
PKG_VERSION:=1.0.0
PKG_RELEASE:=4
PKG_LICENSE:=GPLv3

LUCI_TITLE:=LuCI Support for udp2raw-tunnel
LUCI_DEPENDS:=+udp2raw-tunnel
LUCI_PKGARCH:=all

include ../../luci.mk

# call BuildPackage - OpenWrt buildroot signature
