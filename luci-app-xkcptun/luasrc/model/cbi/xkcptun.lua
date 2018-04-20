-- Copyright (C) 2017 zhangzengfei@kunteng.org
-- Licensed to the public under the GNU General Public License v3.

local sys = require "luci.sys"
local opkg = require "luci.model.ipkg"

local packageName = "xkcptun"
local m, s

if not opkg.status(packageName)[packageName] then
	return Map(packageName, translate("Xkcptun"), translate('<b style="color:red">Xkcptun not installed.</b>'))
end

m = Map("xkcptun", translate("Xkcptun"), translate("<a target=\"_blank\" href=\"https://github.com/liudf0716/xkcptun\">Xkcptun</a> " .. 
															"is a kcp tunnel for OpenWRT, implemented in c language" ))

s = m:section(TypedSection, "client", translate("Client Configuration"))
s.anonymous = true
s.addremove = false

s:tab("general", translate("General Setting"))
s:tab("advanced", translate("Advanced Setting"))

-- 基本设置
Enable = s:taboption("general", Flag, "enable", translate("Enable"),translate("Enable accelerator"))
Enable.default = Enable.enabled

LocalInterface = s:taboption("general", Value, "localinterface", translate("Local Interface"), translate("Specify the listening network interface, default is 'br-lan'"))
LocalInterface.default = "br-lan"
for _, e in ipairs(sys.net.devices()) do
	if e ~= "lo" then LocalInterface:value(e) end
end

LocalPort = s:taboption("general", Value, "localport", translate("Local Port"), translate("Local listening port"))
LocalPort.datatype = "port"
LocalPort.rmempty = false

ServerAddr = s:taboption("general", Value, "remoteaddr", translate("Server IP"), translate("Xkcptun server ip address"))
ServerAddr.rmempty = false

ServerPort = s:taboption("general", Value, "remoteport", translate("Server Port"), translate("Xkcptun server port"))
ServerPort.datatype = "port"
ServerPort.rmempty = false

Crypt = s:taboption("general", Value, "crypt", translate("Crypt Method"), translate("Crypt method"))
Crypt.default = salsa20
Crypt.rmempty = false

Key = s:taboption("general", Value, "key", translate("Session Key"), translate("Session key for connecting to server"))
Key.rmempty = false

Mode = s:taboption("general", Value, "mode", translate("Accelerator Mode"), translate("Accelerator mode"))
Mode.default = "fast"
Mode.rmempty = false

-- 高级设置
MTU = s:taboption("advanced", Value, "mtu", translate("MTU"), translate("maximum transmission unit for UDP packets"))
MTU.datatype = "uinteger"
MTU.placeholder=1350
MTU.rmempty = true

SendWnd = s:taboption("advanced", Value, "sndwnd", translate("sndwnd"), translate("send window size(num of packets)"))
SendWnd.datatype = "uinteger"
SendWnd.placeholder=1024
SendWnd.rmempty = true

RendWnd = s:taboption("advanced", Value, "rcvwnd", translate("rcvwnd"), translate("receive window size(num of packets)"))
RendWnd.datatype = "uinteger"
RendWnd.placeholder=1024
RendWnd.rmempty = true

DataShard = s:taboption("advanced", Value, "datashard", translate("datashard"), translate("reed-solomon erasure coding"))
DataShard.datatype = "uinteger"
DataShard.placeholder=10
DataShard.rmempty = true

Parityshard = s:taboption("advanced", Value, "parityshard", translate("parityshard"), translate("reed-solomon erasure coding"))
Parityshard.datatype = "uinteger"
Parityshard.placeholder=3
Parityshard.rmempty = true

DSCP = s:taboption("advanced", Value, "dscp", translate("dscp"), translate("DSCP(6bit)"))
DSCP.datatype = "uinteger"
DSCP.placeholder=0
DSCP.rmempty = true

NoComp = s:taboption("advanced", Flag, "nocomp", translate("nocomp"), translate("disable compression"))
NoComp.default = NoComp.enabled

AckNodelay = s:taboption("advanced", Flag, "acknodelay", translate("acknodelay"), translate("set ack no delay"))
AckNodelay.default = AckNodelay.disabled

Nodelay = s:taboption("advanced", Flag, "nodelay", translate("nodelay"), translate("set all conn no delay"))
Nodelay.default = Nodelay.disabled

return m
