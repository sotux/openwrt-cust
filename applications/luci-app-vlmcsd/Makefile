#
# Copyright (C) 2018
#
# This is free software, licensed under the MIT
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-vlmcsd
PKG_VERSION:=1.0.2
PKG_RELEASE:=1
PKG_MAINTAINER:=cokebar <cokebar@cokebar.info>
PKG_LICENSE:=MIT

LUCI_TITLE:=LuCI Support for vlmcsd
LUCI_DEPENDS:=+vlmcsd +luci-compat
LUCI_PKGARCH:=all

include ../../luci.mk

# call BuildPackage - OpenWrt buildroot signature
