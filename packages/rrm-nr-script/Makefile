#
# Copyright (C) 2014-2018 OpenWrt-dist
# Copyright (C) 2019 James Qian <sotux82@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rrm-nr-script
PKG_VERSION:=0.0.1
PKG_RELEASE:=1

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=James Qian <sotux82@gmail.com>

include $(INCLUDE_DIR)/package.mk

define Package/rrm-nr-script
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Neighbor report script for 802.11k
	DEPENDS:=+umdns
endef

define Package/rrm-nr-script/description
Generate neighbor report for 802.11k AP
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/rrm-nr-script/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/neighbor_report.init $(1)/etc/init.d/neighbor_report
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/rrm $(1)/usr/bin/rrm
endef

$(eval $(call BuildPackage,rrm-nr-script))
