#
# Copyright (C) 2012-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=kodexplorer
PKG_VERSION:=4.47
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/kodexplorer
	SECTION:=net
  CATEGORY:=Network
  SUBMENU:=File Transfer
	TITLE:=Kod Explorer
	URL:=https://kodcloud.com
	DEPENDS:=+nginx-all-module +php8 +php8-fastcgi +php8-fpm +php8-mod-curl +php8-mod-gd +php8-mod-iconv \
		+php8-mod-mbstring +php8-mod-opcache +php8-mod-session +php8-mod-zip +zoneinfo-core +zoneinfo-asia
endef

define Package/kodexplorer/description
	KodExplorer is a file manager for web. It is also a web code editor, which \
	allows you to develop websites directly within the web browser.
endef

define Build/Compile
endef

define Package/kodexplorer/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) kod_install.sh $(1)/usr/bin/kod_install.sh
endef

$(eval $(call BuildPackage,kodexplorer))
