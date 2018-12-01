local sys = require "luci.sys"
local m, s

local running=(sys.call("pidof vlmcsd > /dev/null") == 0)
if running then	
	m = Map("vlmcsd", translate("vlmcsd config"), translate("Vlmcsd is running."))
else
	m = Map("vlmcsd", translate("vlmcsd config"), translate("Vlmcsd is not running."))
end

s = m:section(TypedSection, "vlmcsd", "")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enabled", translate("Enable"))
enable.rmempty = false

autoactivate = s:option(Flag, "autoactivate", translate("Auto activate"))
autoactivate.rmempty = false

return m