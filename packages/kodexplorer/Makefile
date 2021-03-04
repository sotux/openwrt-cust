#
# Copyright (C) 2012-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=kodexplorer
PKG_VERSION:=4.39
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/kodexplorer
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Kod Explorer
  URL:=https://kodcloud.com
  DEPENDS:=+nginx +php7-fastcgi +php7-fpm +php7-mod-curl +php7-mod-gd +php7-mod-iconv \
    +php7-mod-json +php7-mod-mbstring +php7-mod-opcache +php7-mod-session +php7-mod-zip \
    +zoneinfo-core +zoneinfo-asia
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
