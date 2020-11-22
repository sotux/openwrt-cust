-- Copyright (C) 2014-2018 OpenWrt-dist
-- Copyright (C) 2014-2018 Jian Chang <aa65535@live.com>
-- Licensed to the public under the GNU General Public License v3.

local m, s, o

if luci.sys.call("pidof chinadns-ng >/dev/null") == 0 then
	m = Map("chinadns-ng", translate("chinadns-ng"), "%s - %s" %{translate("chinadns-ng"), translate("RUNNING")})
else
	m = Map("chinadns-ng", translate("chinadns-ng"), "%s - %s" %{translate("chinadns-ng"), translate("NOT RUNNING")})
end

s = m:section(TypedSection, "chinadns-ng", translate("General Setting"))
s.anonymous   = true

o = s:option(Flag, "enable", translate("Enable"))
o.rmempty     = false

o = s:option(Value, "bind_addr", translate("Listen Address"))
o.placeholder = "0.0.0.0"
o.default     = "0.0.0.0"
o.datatype    = "ipaddr"
o.rmempty     = false

o = s:option(Value, "bind_port", translate("Listen Port"))
o.placeholder = 5353
o.default     = 5353
o.datatype    = "port"
o.rmempty     = false

o = s:option(Value, "china_dns", translate("DNS server in China"))
o.placeholder = "114.114.114.114"
o.default     = "114.114.114.114"
o.rmempty     = false

o = s:option(Value, "trust_dns", translate("Trusted DNS server"))
o.placeholder = "1.1.1.1"
o.default     = "1.1.1.1"
o.rmempty     = false

o = s:option(Value, "gfwlist_file", translate("gfwlist_file"))
o.placeholder = "/etc/chinadns-ng/gfwlist.txt"
o.default     = "/etc/chinadns-ng/gfwlist.txt"
o.datatype    = "file"
o.rmempty     = false

o = s:option(Value, "chnlist_file", translate("chnlist_file"))
o.placeholder = "/etc/chinadns-ng/chinalist.txt"
o.default     = "/etc/chinadns-ng/chinalist.txt"
o.datatype    = "file"
o.rmempty     = false

o = s:option(Value, "timeout_sec", translate("timeout_sec"))
o.placeholder = "3"
o.default     = "3"
o.rmempty     = false

o = s:option(Value, "repeat_times", translate("repeat_times"))
o.placeholder = "4"
o.default     = "4"
o.rmempty     = false

o = s:option(Value, "chnlist_first", translate("chnlist_first"))
o.placeholder = "0"
o.default     = "0"
o.rmempty     = false

o = s:option(Value, "fair_mode", translate("fair_mode"))
o.placeholder = "0"
o.default     = "0"
o.rmempty     = false

o = s:option(Value, "reuse_port", translate("reuse_port"))
o.placeholder = "1"
o.default     = "1"
o.rmempty     = false

o = s:option(Value, "noip_as_chnip", translate("noip_as_chnip"))
o.placeholder = "0"
o.default     = "0"
o.rmempty     = false

return m
