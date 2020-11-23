-- Copyright (C) 2017 yushi studio <ywb94@qq.com>
-- Licensed to the public under the GNU General Public License v3.
local IPK_Version = "3.0.9"
local m, s, o
local redir_run = 0
local reudp_run = 0
local kcptun_run = 0
local tunnel_run = 0
local gfw_count = 0
local ad_count = 0
local ip_count = 0
local gfwmode = 0
local ucic = luci.model.uci.cursor()

if nixio.fs.access("/etc/dnsmasq.ssr/gfw_list.conf") then gfwmode = 1 end

local shadowsocksr = "shadowsocksr"
-- html constants
font_blue = [[<font color="green">]]
font_off = [[</font>]]
bold_on = [[<strong>]]
bold_off = [[</strong>]]

local fs = require "nixio.fs"
local sys = require "luci.sys"
local kcptun_version = translate("Unknown")
local kcp_file = "/usr/bin/kcptun-c"
if not fs.access(kcp_file) then
    kcptun_version = translate("Not exist")
else
    if not fs.access(kcp_file, "rwx", "rx", "rx") then
        fs.chmod(kcp_file, 755)
    end
    kcptun_version = sys.exec(kcp_file .. " -v | awk '{printf $3}'")
    if not kcptun_version or kcptun_version == "" then
        kcptun_version = translate("Unknown")
    end

end

if gfwmode == 1 then
    gfw_count =
        tonumber(sys.exec("cat /etc/dnsmasq.ssr/gfw_list.conf | wc -l")) / 2
    if nixio.fs.access("/etc/dnsmasq.ssr/ad.conf") then
        ad_count = tonumber(sys.exec("cat /etc/dnsmasq.ssr/ad.conf | wc -l"))
    end
end

if nixio.fs.access("/etc/china_ssr.txt") then
    ip_count = sys.exec("cat /etc/china_ssr.txt | wc -l")
end

local icount = sys.exec("busybox ps -w | grep ssr-reudp |grep -v grep| wc -l")
if tonumber(icount) > 0 then
    reudp_run = 1
else
    icount = sys.exec(
                 "busybox ps -w | grep ssr-retcp |grep \"\\-u\"|grep -v grep| wc -l")
    if tonumber(icount) > 0 then reudp_run = 1 end
end

if luci.sys.call("busybox ps -w | grep ssr-retcp | grep -v grep >/dev/null") ==
    0 then redir_run = 1 end

if luci.sys.call("pidof kcptun-c >/dev/null") == 0 then kcptun_run = 1 end

if luci.sys.call("busybox ps -w | grep ssr-tunnel |grep -v grep >/dev/null") ==
    0 then tunnel_run = 1 end

if luci.sys.call("pidof pdnsd >/dev/null") == 0 then pdnsd_run = 1 end

m = SimpleForm("Version")
m.reset = false
m.submit = false

s = m:field(DummyValue, "redir_run", translate("Global Client"))
s.rawhtml = true
if redir_run == 1 then
    s.value = font_blue .. bold_on .. translate("Running") .. bold_off ..
                  font_off
else
    s.value = translate("Not Running")
end

s = m:field(DummyValue, "reudp_run", translate("Game Mode UDP Relay"))
s.rawhtml = true
if reudp_run == 1 then
    s.value = font_blue .. bold_on .. translate("Running") .. bold_off ..
                  font_off
else
    s.value = translate("Not Running")
end

s = m:field(DummyValue, "pdnsd_run", translate("PDNSD"))
s.rawhtml = true
if pdnsd_run == 1 then
    s.value = font_blue .. bold_on .. translate("Running") .. bold_off ..
                  font_off
else
    s.value = translate("Not Running")
end

if nixio.fs.access("/usr/bin/kcptun-c") then
    s = m:field(DummyValue, "kcp_version", translate("KcpTun Version"))
    s.rawhtml = true
    s.value = kcptun_version

    s = m:field(DummyValue, "kcptun_run", translate("KcpTun"))
    s.rawhtml = true
    if kcptun_run == 1 then
        s.value = font_blue .. bold_on .. translate("Running") .. bold_off ..
                      font_off
    else
        s.value = translate("Not Running")
    end
end

s = m:field(DummyValue, "google", translate("Google Connectivity"))
s.value = translate("No Check")
s.template = "shadowsocksr/check"

s = m:field(DummyValue, "baidu", translate("Baidu Connectivity"))
s.value = translate("No Check")
s.template = "shadowsocksr/check"

if gfwmode == 1 then
    s = m:field(DummyValue, "gfw_data", translate("GFW List Data"))
    s.rawhtml = true
    s.template = "shadowsocksr/refresh"
    s.value = tostring(math.ceil(gfw_count)) .. " " .. translate("Records")
end

if ucic:get_first(shadowsocksr, 'global', 'adblock', '') == '1' then
    s = m:field(DummyValue, "ad_data", translate("Advertising Data"))
    s.rawhtml = true
    s.template = "shadowsocksr/refresh"
    s.value = ad_count .. " " .. translate("Records")
end

s = m:field(DummyValue, "ip_data", translate("China IP Data"))
s.rawhtml = true
s.template = "shadowsocksr/refresh"
s.value = ip_count .. " " .. translate("Records")

s = m:field(DummyValue, "check_port", translate("Check Server Port"))
s.template = "shadowsocksr/checkport"
s.value = translate("No Check")

return m
