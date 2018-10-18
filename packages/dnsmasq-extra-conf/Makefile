#
# Copyright (C) 2014-2018 Zheng Qian <sotux82@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnsmasq-extra-conf
PKG_VERSION:=0.0.1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Extra dnsmasq configure files
  DEPENDS:=+dnsmasq-full
  PKGARCH:=all
endef

define Package/$(PKG_NAME)/description
Extra dnsmasq configure files
endef

define Package/$(PKG_NAME)/conffiles
/etc/dnsmasq.d/iptv.conf
/etc/dnsmasq.d/bogus-nxdomain.china.conf
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/dnsmasq.d
	$(INSTALL_CONF) ./files/iptv.conf $(1)/etc/dnsmasq.d/iptv.conf
	$(INSTALL_CONF) ./files/bogus-nxdomain.china.conf $(1)/etc/dnsmasq.d/bogus-nxdomain.china.conf
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
