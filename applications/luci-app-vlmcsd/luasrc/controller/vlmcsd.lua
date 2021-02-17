module("luci.controller.vlmcsd", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/vlmcsd") then
		return
	end
	local e = entry({"admin", "services", "vlmcsd"},
		alias("admin", "services", "vlmcsd", "general"),
		_("vlmcsd"), 10)
	e.dependent = true
	e.acl_depends = { "luci-app-vlmcsd" }

	entry({"admin", "services", "vlmcsd", "general"},
		cbi("vlmcsd/general"),
		_("General Settings"), 10).leaf = true

	entry({"admin", "services", "vlmcsd", "config"},
		form("vlmcsd/configfile"),
		_("Config File"), 20).leaf = true
end
