include $(TOPDIR)/rules.mk

PKG_NAME:=loyalsoldier-geodata
PKG_RELEASE:=1

PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=sotux82 <sotux82@gmail.com>

include $(INCLUDE_DIR)/package.mk

GEOIP_VER:=202310132208
GEOIP_FILE:=geoip.dat.$(GEOIP_VER)
define Download/geoip
  URL:=https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/$(GEOIP_VER)
  URL_FILE:=geoip.dat
  FILE:=$(GEOIP_FILE)
  HASH:=1c48163c41a7f1204f5aa2b33eae77b5f21bea7dad77de9a84032807202966fd
endef

GEOSITE_VER:=202308112208
GEOSITE_FILE:=geosite.dat.$(GEOSITE_VER)
define Download/geosite
  URL:=https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/$(GEOSITE_VER)/
  URL_FILE:=geosite.dat
  FILE:=$(GEOSITE_FILE)
  HASH:=e5018655fa1cf3aa34cd2f96543f5685c548fc5330c3bd4428511b68314b8542
endef

define Package/loyalsoldier-geodata/template
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  URL:=https://github.com/Loyalsoldier/v2ray-rules-dat
  PKGARCH:=all
endef

define Package/loyalsoldier-geoip
  $(call Package/loyalsoldier-geodata/template)
  TITLE:=Loyalsoldier GeoIP List for xray/v2ray/daed
  VERSION:=$(GEOIP_VER)-$(PKG_RELEASE)
  LICENSE:=GPLv3
endef

define Package/loyalsoldier-geosite
  $(call Package/loyalsoldier-geodata/template)
  TITLE:=Loyalsoldier Geosite List for xray/v2ray/daed
  VERSION:=$(GEOSITE_VER)-$(PKG_RELEASE)
  LICENSE:=GPLv3
endef

define Build/Prepare
	$(call Build/Prepare/Default)
ifneq ($(CONFIG_PACKAGE_loyalsoldier-geoip),)
	$(call Download,geoip)
endif
ifneq ($(CONFIG_PACKAGE_loyalsoldier-geosite),)
	$(call Download,geosite)
endif
endef

define Build/Compile
endef

define Package/loyalsoldier-geoip/install
	$(INSTALL_DIR) $(1)/usr/share/v2ray $(1)/usr/share/xray $(1)/usr/share/daed
	$(INSTALL_DATA) $(DL_DIR)/$(GEOIP_FILE) $(1)/usr/share/v2ray/LoyalsoldierIP.dat
	$(LN) ../v2ray/LoyalsoldierIP.dat $(1)/usr/share/xray/LoyalsoldierIP.dat
	$(LN) ../v2ray/LoyalsoldierIP.dat $(1)/usr/share/daed/LoyalsoldierIP.dat
endef

define Package/loyalsoldier-geosite/install
	$(INSTALL_DIR) $(1)/usr/share/v2ray $(1)/usr/share/xray $(1)/usr/share/daed
	$(INSTALL_DATA) $(DL_DIR)/$(GEOSITE_FILE) $(1)/usr/share/v2ray/LoyalsoldierSite.dat
	$(LN) ../v2ray/LoyalsoldierSite.dat $(1)/usr/share/xray/LoyalsoldierSite.dat
	$(LN) ../v2ray/LoyalsoldierSite.dat $(1)/usr/share/daed/LoyalsoldierSite.dat
endef

$(eval $(call BuildPackage,loyalsoldier-geoip))
$(eval $(call BuildPackage,loyalsoldier-geosite))
