#
# Copyright (C) 2014-2018 Jian Chang <aa65535@live.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shadowsocks-libev-alt
PKG_VERSION:=3.3.5
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/shadowsocks/shadowsocks-libev.git
PKG_SOURCE_VERSION:=8285e5a7de093b8ae5a2ca68f7108e6f273092b1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.xz

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Jian Chang <aa65535@live.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1

PKG_CONFIG_DEPENDS:= \
	CONFIG_SHADOWSOCKS_STATIC_LINK \
	CONFIG_SHADOWSOCKS_WITH_EV \
	CONFIG_SHADOWSOCKS_WITH_PCRE \
	CONFIG_SHADOWSOCKS_WITH_CARES \
	CONFIG_SHADOWSOCKS_WITH_SODIUM \
	CONFIG_SHADOWSOCKS_WITH_MBEDTLS

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Lightweight Secured Socks5 Proxy
	URL:=https://github.com/shadowsocks/shadowsocks-libev
	DEPENDS:=+zlib +libpthread \
		+!SHADOWSOCKS_WITH_EV:libev \
		+!SHADOWSOCKS_WITH_PCRE:libpcre \
		+!SHADOWSOCKS_WITH_CARES:libcares \
		+!SHADOWSOCKS_WITH_SODIUM:libsodium \
		+!SHADOWSOCKS_WITH_MBEDTLS:libmbedtls
endef

Package/$(PKG_NAME)-server = $(Package/shadowsocks-libev-alt)

define Package/$(PKG_NAME)-server/config
menu "Shadowsocks-libev Compile Configuration"
	depends on PACKAGE_$(PKG_NAME) || PACKAGE_$(PKG_NAME)-server
	config SHADOWSOCKS_STATIC_LINK
		bool "enable static link libraries."
		default n

		menu "Select libraries"
			depends on SHADOWSOCKS_STATIC_LINK
			config SHADOWSOCKS_WITH_EV
				bool "static link libev."
				default y

			config SHADOWSOCKS_WITH_PCRE
				bool "static link libpcre."
				default y

			config SHADOWSOCKS_WITH_CARES
				bool "static link libcares."
				default y

			config SHADOWSOCKS_WITH_SODIUM
				bool "static link libsodium."
				default y

			config SHADOWSOCKS_WITH_MBEDTLS
				bool "static link libmbedtls."
				default y
		endmenu
endmenu
endef

define Package/$(PKG_NAME)/description
Shadowsocks-libev is a lightweight secured socks5 proxy for embedded devices and low end boxes.
endef

Package/$(PKG_NAME)-server/description = $(Package/shadowsocks-libev-alt/description)

CONFIGURE_ARGS += \
	--disable-ssp \
	--disable-documentation \
	--disable-assert

ifeq ($(CONFIG_SHADOWSOCKS_STATIC_LINK),y)
	ifeq ($(CONFIG_SHADOWSOCKS_WITH_EV),y)
		CONFIGURE_ARGS += --with-ev="$(STAGING_DIR)/usr"
	endif
	ifeq ($(CONFIG_SHADOWSOCKS_WITH_PCRE),y)
		CONFIGURE_ARGS += --with-pcre="$(STAGING_DIR)/usr"
	endif
	ifeq ($(CONFIG_SHADOWSOCKS_WITH_CARES),y)
		CONFIGURE_ARGS += --with-cares="$(STAGING_DIR)/usr"
	endif
	ifeq ($(CONFIG_SHADOWSOCKS_WITH_SODIUM),y)
		CONFIGURE_ARGS += --with-sodium="$(STAGING_DIR)/usr"
	endif
	ifeq ($(CONFIG_SHADOWSOCKS_WITH_MBEDTLS),y)
		CONFIGURE_ARGS += --with-mbedtls="$(STAGING_DIR)/usr"
	endif
	CONFIGURE_ARGS += LDFLAGS="-Wl,-static -static -static-libgcc"
endif

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-{local,redir,tunnel} $(1)/usr/bin
endef

define Package/$(PKG_NAME)-server/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-server $(1)/usr/bin
endef

$(eval $(call BuildPackage,shadowsocks-libev-alt))
$(eval $(call BuildPackage,shadowsocks-libev-alt-server))
