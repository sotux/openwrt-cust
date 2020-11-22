-- Copyright (C) 2014-2018 OpenWrt-dist
-- Copyright (C) 2014-2018 Jian Chang <aa65535@live.com>
-- Licensed to the public under the GNU General Public License v3.

module("luci.controller.chinadns-ng", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/chinadns-ng") then
		return
	end

	entry({"admin", "services", "chinadns-ng"}, cbi("chinadns-ng"), _("chinadns-ng"), 70).dependent = true
end
