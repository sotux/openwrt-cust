module("luci.controller.vlmcsd", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/vlmcsd") then
		return
	end
	entry({"admin", "services", "vlmcsd"},
		alias("admin", "services", "vlmcsd", "general"), 
		_("vlmcsd"), 10).dependent = true
	
	entry({"admin", "services", "vlmcsd", "general"},
		cbi("vlmcsd/general"),
		_("General Settings"), 10).leaf = true
		
	entry({"admin", "services", "vlmcsd", "config"},
		form("vlmcsd/configfile"),
		_("Config File"), 20).leaf = true
end
