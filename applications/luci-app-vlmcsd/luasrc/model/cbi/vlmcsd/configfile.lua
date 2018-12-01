local fs = require "nixio.fs"
local configfile = "/etc/vlmcsd.ini" 

f = SimpleForm("_ini", translate("Config File"),
	translate("This file is /etc/vlmcsd.ini."))

t = f:field(TextValue, "_data")
t.rmempty = true
t.wrap    = "off"
t.rows    = 15

function t.cfgvalue()
	return fs.readfile(configfile) or ""
end

function f.handle(self, state, data)
	if state == FORM_VALID then
		if data._data then
			fs.writefile(configfile, data._data:gsub("\r\n", "\n"))
		else
			fs.writefile(configfile, "")
		end
		luci.sys.call("/etc/init.d/vlmcsd restart")
	end
	return true
end

return f